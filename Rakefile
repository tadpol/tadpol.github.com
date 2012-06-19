# copyright 2007-2009 michael conrad tadpol tilstra
require 'rubygems'
require 'time'
require 'rake/clean'
require 'tools/website.rb'

ENV['PATH'] += ':/Users/tadpol/bin'


SRC_TYPES = '*.{text,txt,markdown,rit}'
# What things to excludes when building feeds.
EXCLUDE_DIRS = %w{images panoramic moovs tools h s Links macstuf vacation}
EXCLUDE_FILES = %w{contact.rit index.text index.rit archive.text 404.text info.txt robots.txt}

$atr = WebSpace::AtomRender.new(:title => "Tadpol's bog",
                                :base => 'http://tadpol.org',
                                :name => 'feed.atom',
                                :icon => '/favicon.ico',
                                :author => 'Michael Conrad Tadpol Tilstra',
                                :rights => 'All rights reserved.')
$basic = WebSpace::TemplateRender.new(File.open('tools/basic.tmpl').read)
$rooted = WebSpace::TemplateRender.new(File.open('tools/rooted.tmpl').read)

$fltr = WebSpace::Filter.new([:group_links, :group_blog, :image_fix, :thickbox_href_fix, :recipe_table],
                             {:group_excludes=>EXCLUDE_FILES})

# This doesn't always work as I expect, so just building feeds explictily.
# def dir_feed_rule(dir)
#     dir = Pathname.new(dir) unless dir.kind_of?(Pathname)
#     src = FileList[dir+SRC_TYPES].exclude(*EXCLUDE_FILES)
#     src.add(FileList[dir+'*'].exclude(*EXCLUDE_DIRS){|p| not File.directory? p}.collect{|p| p+'/feed.atom'})
#     dst = dir + 'feed.atom'
#     
# #    $stderr.puts "Generating file rule for :: #{dst} => #{src}"
#     file dst => src do |t|
#         puts "Building #{t.name}"
#         fe = WebSpace::Load(t.prerequisites.to_a).collect{|e| $fltr.go(e)}
#         fe = fe.sort.reverse[0..14]
#         File.open(t.name, 'w'){|io| io << $atr.render(fe) }
#     end
# end
# 
# # Build the rules for building feeds in directories.
# FileList['.','bog/', 'projects/', 'recipes/'].exclude{|p| not File.directory? p}.each{|dir| dir_feed_rule(dir)}
CLEAN.include('**/feed.atom')

desc "Build everything."
task :default => ['feed.atom'] do
    puts 'Done.'
end

# Build individual html pages for the entries.
CLEAN.include('**/*.html')
multitask :default => FileList['**/'+SRC_TYPES].exclude(*%w{info.txt robots.txt}).ext('html')

### Build Feeds
file 'bog/feed.atom' => FileList['bog/*.{text,txt,rit}'].exclude(*%w{index.text archive.text}) do |t|
    puts "Building #{t.name}"
    fe = WebSpace::Load(t.prerequisites.to_a).collect{|e| $fltr.go(e)}
    fe = fe.sort.reverse[0..14]
    File.open(t.name, 'w'){|io| io << $atr.render(fe) }
end
file 'projects/feed.atom' => FileList['projects/*.{text,txt,markdown,rit}'].exclude(*%w{index.text archive.text}) do |t|
    puts "Building #{t.name}"
    fe = WebSpace::Load(t.prerequisites.to_a).collect{|e| $fltr.go(e)}
    fe = fe.sort.reverse[0..14]
    File.open(t.name, 'w'){|io| io << $atr.render(fe) }
end

file 'recipes/feed.atom' => FileList['recipes/*.{text,txt,rit}'].exclude(*%w{index.text archive.text}) do |t|
    puts "Building #{t.name}"
    fe = WebSpace::Load(t.prerequisites.to_a).collect{|e| $fltr.go(e)}
    fe = fe.sort.reverse[0..14]
    File.open(t.name, 'w'){|io| io << $atr.render(fe) }
end

file 'feed.atom' => FileList['{bog,projects,recipes}/feed.atom'] do |t|
    puts "Building #{t.name}"
    fe = WebSpace::Load(t.prerequisites.to_a).collect{|e| $fltr.go(e)}
    fe = fe.sort.reverse[0..14]
    File.open(t.name, 'w'){|io| io << $atr.render(fe) }
end

### Build Files
file '404.html'  do |t|
    puts "Building #{t.name}"
    e = WebSpace::Load('404.text')
    File.open(t.name, 'w') {|io| io << $rooted.render($fltr.go(e))}
end

# Would prefer a single rule if possible.
rule '.html' => ['.text'] do |t|
    puts "Building #{t.name}"
    e = WebSpace::Load(t.source)
    File.open(t.name, 'w') {|io| io << $basic.render($fltr.go(e))}
end
rule '.html' => ['.txt'] do |t|
    puts "Building #{t.name}"
    e = WebSpace::Load(t.source)
    File.open(t.name, 'w') {|io| io << $basic.render($fltr.go(e))}
end
rule '.html' => ['.markdown'] do |t|
    puts "Building #{t.name}"
    e = WebSpace::Load(t.source)
    File.open(t.name, 'w') {|io| io << $basic.render($fltr.go(e))}
end
rule '.html' => ['.rit'] do |t|
    puts "Building #{t.name}"
    e = WebSpace::Load(t.source)
    File.open(t.name, 'w') {|io| io << $basic.render($fltr.go(e))}
end


# depends
file 'recipes/index.html' => FileList['recipes/*.{text,txt,rit}']
file 'projects/index.html' => FileList['projects/*.{text,txt,markdown,rit}']
file 'bog/index.html' => FileList['bog/*.{text,txt,rit}']
file 'bog/archive.html' => FileList['bog/*.{text,txt,rit}']
file 'index.html' => FileList['{bog,projects}/*.{text,txt,markdown,rit}']

# hacks
desc "Force everyone's mod time to be created time"
task :modascreated do
    FileList['**/'+SRC_TYPES].exclude(*%w{info.txt robots.txt}).each do |file|
        e = WebSpace::Load(file)
        %x{echo touch -m -t #{e.modified.strftime('%Y%m%d%H%M')} #{file}}
    end
end


desc "Find all of the Markup links"
task :alllinks do
    linkdb = Hash.new
    FileList['**/'+SRC_TYPES].exclude(*%w{info.txt robots.txt}).each do |file|
        Pathname.new(file).each_line do |line|
            if line =~ %r{\[(\w+)\]:\s+(.*)} then
                if not linkdb.has_key? $1 then
                    linkdb[$1] = Array.new
                end
                linkdb[$1] << $2
            end
        end
    end
    linkdb.keys.sort.each do |k|
        puts "#{k}\t #{linkdb[k].sort.uniq}"
    end
end

desc "Upload changes"
task :upload do
    %x{echo interarchy -b }
end
