# copyright 2006-2012 michael conrad tilstra <tadpol@tadpol.org>

require 'pathname'
require 'builder'
require 'hpricot'
#require 'maruku'
require 'dimensions'
require 'time'

module WebSpace

# This will return either a single Entry or an Array of Entries
def WebSpace::Load(arg)
    if arg.kind_of?(Array)
        arg.collect{|a| Load(a)}.flatten
    else
        case arg.to_s
            when /.(rit|tmpl)$/
                Entry.load_rit(arg)
            when /.te?xt$/
                Entry.load_blosxom(arg)
			when /.markdown$/
                Entry.load_blosxom(arg)
            when /.atom$/
                dc = Hpricot.XML(File.open(arg))
                out = Array.new
                (dc/"/feed/entry").each do |entry|
                    e = Entry.new
                    e[:title] = (entry%"title").inner_text
                    e[:htmlname] = (entry%"link")[:href]   # this makes some heavy assumptions.
                    e[:base] = entry['xml:base']
                    e[:id] = (entry%"id").inner_text
                    e[:created] = Time.parse((entry%"published").inner_text)
                    e[:modified] = Time.parse((entry%"updated").inner_text)
                    # FIXME shouldn't need to go inside div, but hack for AtomRender
                    e[:content] = Hpricot((entry%"content/div").innerHTML)
                    out << e.fixup
                end
                out
            else
                raise "Don't know how to import #{arg} into an Entry"
        end
    end
end

Entry = Struct.new('Entry',
                   :title,      # The name of this entry. Appears in page title.  (String)
                   :id,         # unique id for entry.  (String)
                   :created,    # When this entry was created  (Time)
                   :modified,   # When this entry was last modified  (Time)
                   :content,    # The entry details  (Hpricot)
                   :tagline,    # Cute short, one line descriptive alternate title for entry. (String)
                   :base,       # Which sub directory this Entry is at  (Pathname)
                   :htmlname    # Name of the html file that holds the rendered version. (Pathname)
                   )


#### Loaders
# Take whatever supported import format, and create a new Entry from it.
#
# ??? wonder if having a cache of Entries would be useful.  Much later.

def Entry.load_blosxom(path)
    path = Pathname.new(path) unless path.kind_of? Pathname
    ret = Entry.new
    ret.setup(path)
    md = path.readlines.join('').match %r{^([^\n]+)\n((#[^\n]+\n)*)(.*)}m
    ret[:title] = md[1]
    md[2].split(/\n/).each do |meta|
        meta.strip =~ /^#(\S+)\s+(.*)/
        ret[$1.to_sym] = $2
    end
#    ret.content = Maruku.new(md[4]).to_html # Maruku is way too strick about inlined html.
    IO.popen("Markdown|SmartyPants", 'r+') do |io|
        io.puts md[4]
        io.close_write
        ret.content = io.read
    end    
    ret.fixup
    ret
end

def Entry.load_rit(path)
    path = Pathname.new(path) unless path.kind_of? Pathname
    ret = Entry.new
    ret.setup(path)
    ret.content = ''
    path.readlines.each do |line|
        case line
        when /<!-- define (\S+)\s+"([^"]*)"/
            k=$1.to_sym
            v=$2
            case k
            when :subject
                k=:title
            end
            ret[k] = v
        else
            ret.content << line
        end
    end
    ret.fixup
    ret
end

# Various methods that get added to the Entry.
class Entry
#    include Comparable
    
    def <=>(o)
        self.modified<=>o.modified
    end
    
    def setup(path)
        self.base = path.dirname
        self.htmlname = Pathname.new(path.basename.to_s.sub(/.[^.]+$/, '.html'))
        self.id = self.base + self.htmlname
        self.created = path.mtime
        self.modified = path.mtime
    end
    
    def fixup
        self.htmlname = Pathname.new(self.htmlname) unless self.htmlname.kind_of?(Pathname)
        self.base = Pathname.new(self.base) unless self.base.kind_of?(Pathname)
        self.created = Time.parse(self.created) unless self.created.kind_of?(Time)
        self.modified = Time.parse(self.modified) unless self.modified.kind_of?(Time)
        self.content = Hpricot(self.content) unless self.content.kind_of?(Hpricot::Doc)
        self
    end
    
    def copyyears
        [self.created.year, Time.now.year].uniq.join('-')
    end
    
    # Using title, tagline, base, and htmlname, produce an anchor tag to this entry's html page.
	def to_href(outbase)
	    link = (self.base + self.htmlname).relative_path_from(outbase)
		if not self.tagline.nil?
			if self.tagline =~ /\{[^\}]*\}/
				self.tagline.gsub(/\{([^\}]*)\}/) {|m| %{<a href="#{link}">#{$1}</a>} }
			else
				%{<a href="#{link}">#{self.tagline}</a>}
			end
		else
			%{<a href="#{link}">#{self.title}</a>}
		end
	end
end

# Modifications onto an Entry.
#
# There is a lot of this class that is just weird.  I'm not convinced its the best way to do what it does.  However I'm tired of trying to think of something better, so I am just using this.
# Its still better than what I was doing before.
class Filter
    # Create a new Filter
    #
    # Maybe should have this default to all internal filter methods?
    def initialize(filters=[], options={})
        @filters = filters
        @filters.each{|f| raise "#{f.to_s} is not a valid filter" unless self.respond_to? f}
        
        # set some default options
        @options = {}
        @options[:group_excludes] = []
        @options[:image_types] = %w{png jpg jpeg gif}
        @options[:image_paths] = %w{. images}
        # overwrite requested values.
        @options.merge!(options)
    end
    
    def go(entry)
        @filters.each{|f| entry = self.method(f)[entry] }
        entry
    end
    
    #filters go here
    
    # look for various mungings of a ingredient table and make it into a html table.
    def recipe_table(entry)
        e = (entry.content/"p[text()^='Amount']").to_a
        e.push(*((entry.content/"pre/code[text()*='Amount']/..").to_a))
        e.each do |table|
            xml = Builder::XmlMarkup.new(:indent=>2)
            xml.table(:class=>'recipe') do
                xml.tr {
                    xml.td 'Amount'
                    xml.td 'Measure'
                    xml.td 'Ingredient — Preparation'
                }
                table.inner_text.split(/\n/).each do |line|
                    case line
                    when %r{Amount\s+Measure}
                    when %r{-+\s+-+}
                    when %r{\s*(.{8})  (.{12})  (.*)}
                        xml.tr {
                            xml.td $1.strip
                            xml.td $2.strip
                            xml.td{xml<< $3.strip}
                        }
                    end
                end
            end
            table.swap(xml.target!)
        end
        entry
    end
    
    # Locate the actual image file, and clean up attributes based on it.
    def image_fix(entry)
        l = @options[:image_paths].collect{|p| (entry.base + p).to_s} + @options[:image_paths]
        lookin = '{' + l.join(',') + '}'
        types = '{' + @options[:image_types].join(',') + '}'
        
        # TODO skip image tags that start with 'http'
        (entry.content/"img").each do |img|
            src = Pathname.new(img['src'])
#            $stderr.puts "==== was: #{src}"
            # Find real location of image
            if not src.exist?
                g = %{#{lookin}/#{src.to_s}}
                g += ".#{types}" unless g =~ /\..+$/
                reals = Pathname.glob(g)
                next if reals.nil? or reals.empty?  # no image found, skip this tag.
#                $stderr.puts "==== found: #{reals[0]}"
                src = reals[0]
                img['src'] = src.relative_path_from(entry.base).to_s
#                $stderr.puts "==== relocated: #{img['src']}"
            end
            # touch up attributes in img tag
            # Don't replace if present, to allow overriding.
			img['height'] = Dimensions.height(src.to_s).to_s unless img.has_attribute? 'height'
			img['width'] = Dimensions.width(src.to_s).to_s unless img.has_attribute? 'width'
        end
        entry
    end
    
    # Locate <a href clas="thickbox"> elements and do path fixing on the url and add a rel based
    # on the entry. (force all images on a page to be in a group.) (only if there is no rel) 
    def thickbox_href_fix(entry)
        l = @options[:image_paths].collect{|p| (entry.base + p).to_s} + @options[:image_paths]
        lookin = '{' + l.join(',') + '}'
        types = '{' + @options[:image_types].join(',') + '}'

        (entry.content/"a.thickbox").each do |img|
            src = Pathname.new(img['href'])
#            $stderr.puts "==== was: #{src}"
            # Find real location of image
            if not src.exist?
                g = %{#{lookin}/#{src.to_s}}
                g += ".#{types}" unless g =~ /\..+$/
                reals = Pathname.glob(g)
                next if reals.nil? or reals.empty?  # no image found, skip this tag.
#                $stderr.puts "==== found: #{reals[0]}"
                src = reals[0]
                img['href'] = src.relative_path_from(entry.base).to_s
#                $stderr.puts "==== relocated: #{img['src']}"
            end
            
            # ok, now add a rel attribute if there isn't one already
            img['rel'] = entry.id.to_s.gsub(/\W/,'') unless img.has_attribute? 'rel'

        end
        entry
    end
        
    def group_blog(entry)
        (entry.content/"group_blog").each do |gb|
            src = gb['src']
            excludes = @options[:group_excludes]
            excludes += gb[:exclude].split() if gb.has_attribute? :exclude
            es = WebSpace::Load(Pathname.glob(entry.base + src) - excludes.map{|e| entry.base + e})
            es = es.sort.reverse
            es = es[Range.new(0, gb[:limit].to_i - 1)] if gb.has_attribute? :limit

            xml = Builder::XmlMarkup.new(:indent=>2)
            xml.div(:class=>'blogdex') do
                es.each do |e|
                    xml.div(:class=>'snippet') do
                        xml.h2 {xml << e.to_href(entry.base)}
                        xml.div(:class=>'dates') do
                            xml.span 'Created ' + e.created.to_s, :class=>'created'
                            xml.span 'Modified ' + e.modified.to_s, :class=>'modified'
                        end
                        xml << e.content.to_s
                    end
                end
            end
            gb.swap(xml.target!)
        end
        entry
    end #group_blog
    
    def group_links(entry)
        monthsasnames = ['Zeroth', 'January', 'February', 'March', 'April', 'May', 
        'June', 'July', 'August', 'September', 'October', 'November', 'December']
        (entry.content/"group_links").each do |gb|
            src = gb['src']
            excludes = @options[:group_excludes]
            excludes += gb[:exclude].split() if gb.has_attribute? :exclude
            es = WebSpace::Load(Pathname.glob(entry.base + src) - excludes.map{|e| entry.base + e})
            # limit range is backwards from default sort.
            es = es.sort[Range.new(- gb[:limit].to_i, -1)] if gb.has_attribute? :limit

            xml = Builder::XmlMarkup.new(:indent=>2)
            xml.ul :class=>'timeindex' do
                if es.length > 12
                    years = Hash.new
                    es.each do |it|
                        y = it.created.year.to_s
                        years[y] = Array.new unless years.has_key? y
                        years[y].push it
                    end
                    years.sort.reverse.each do |yr|
                        year, items = yr
                        xml.li do
                            xml.text! year
                            xml.ul do
                                if items.length > 12
                                    months = Hash.new
                                    items.each do |it|
                                        m = it.created.month
                                        months[m] = Array.new unless months.has_key? m
                                        months[m].push it
                                    end
                                    months.sort.reverse.each do |mth|
                                        month, items = mth
                                        xml.li do
                                            xml.text! monthsasnames[month]
                                            xml.ul do
                                                items.sort.reverse.each{|wsi|
                                                    xml.li{xml << wsi.to_href(entry.base)}
                                                }
                                            end
                                        end
                                    end
                                else
                                    items.sort.reverse.each {|wsi| xml.li{xml << wsi.to_href(entry.base)}}
                                end
                            end
                        end
                    end
                else
                    es.sort.reverse.each {|wsi| xml.li{xml << wsi.to_href(entry.base)}}
                end
            end
            gb.swap(xml.target!)
        end
        entry
    end #group_links
end


class Render
end

class TemplateRender < Render
    def initialize(template=nil)
        @template = %{<html>
<head><title><tmpl:title/></title></head>
<body><h1><tmpl:title/></h1><tmpl:bodytext/></body>
</html>}
        @template = template unless template.nil?
    end
    
    def render(entry)
        raise "Must be Entry, but was #{entry.class}" unless entry.kind_of?(Entry)
        dc = Hpricot(@template) # Need new hpricot for every time this is run.
        (dc/'tmpl:title').each{|t| t.swap(entry.title)}
        (dc/'tmpl:copyrightyears').each{|t| t.swap(entry.copyyears)}
        (dc/'meta[@name="created"]').each{|t| t['content'] = entry.created.xmlschema}
        
        # This is a hack to relocate the #topdir# links.  Should someday be replaced with something smarter. (ie get rid of or replace the #topdir# crap.)
        (dc/'*[@src^="#topdir#"], *[@href^="#topdir#"]').each do |e|
            k=:href
            k=:src if e.has_attribute? :src
            l = e[k].sub(%r{#topdir#/},'')
            e[k] = Pathname.new(l).relative_path_from(entry.base).to_s
        end
        
        # subbing in bodytext needs to be last. Otherwise we'll walk over the entry contents.
        (dc/'tmpl:bodytext').each{|t| t.swap(entry.content.to_s)}
        dc = sink_script_tags(dc)
        dc.to_s
    end
    
    # This is a post filter. Normally filters only run over the pre-template data.
    # This one is an exception to that, we try to avoid this.
    # This takes all script tags and moves them to the bottom of the body tag, while keeping them in
    # their original order.
    def sink_script_tags(doc)
        # First copy the script tags out...
        allscripts = (doc/"body script").to_html
        # remove them...
        (doc/"body script").remove
        # Now replace at end.
        doc.at("body :last").after allscripts
        doc
    end
    
end

class AtomRender < Render
    def initialize(h)
        @title = h[:title] or raise 'Forgot title.'
        @base = h[:base] or raise 'Forgot base.'
        @name = h[:name] or raise 'Forgot name.'
        @author = h[:author] or raise 'Forgot author.'
        @rights = h[:rights] or "All rights reserved."
        @icon = h[:icon]
        @id = @base + '/' + @name
    end
    
    def render(entries=[])
        entries = [entries] unless entries.kind_of?(Array)
        base = Pathname.new(@base)
        xml = Builder::XmlMarkup.new(:indent=>2)
		xml.instruct!
		xml.feed('xmlns'=>'http://www.w3.org/2005/Atom',
		         'xml:base'=>@id,
		         'xml:lang'=>'en-us'
		        ) do
			xml.title @title
			xml.id @id
			xml.link 'rel'=>'self', 'href'=> @name
			xml.link 'rel'=>'alternate', 'href'=> @base
			xml.icon @icon unless @icon.nil?
			xml.updated Time.now.xmlschema
			xml.author { xml.name @author }
			xml.rights @rights
			xml.generator %{WebSpace 0.1 ruby code written by Michael Conrad Tadpol Tilstra}
			
			entries.each do |wsi|
				xml.entry('xml:base'=>(wsi.base.to_s + '/')) do
					xml.title wsi.title
					xml.link 'href'=> wsi.htmlname
					xml.id base + wsi.id
					xml.published wsi.created.xmlschema
					xml.updated wsi.modified.xmlschema
					xml.content('type'=>'xhtml') do
					    # FIXME Need to check to see if div is needed or not.
                        xml.div('xmlns'=>'http://www.w3.org/1999/xhtml'){xml << wsi.content.to_s}
					end
				end
			end
		end
		xml.target!
    end
end


end #module WebSpace
