#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# gfm2html.rb
# Time-stamp: <2015-05-07 11:50:59 takeshi>
# Copying:
#    Copyright © 2015 by Takeshi Nishimatsu
#    gfm2html.rb is distributed in the hope that
#    it will be useful, but WITHOUT ANY WARRANTY.
#    You can copy, modify and redistribute gfm2html.rb,
#    but only under the conditions described in
#    the GNU General Public License version 3 (the "GPLv3").
##
require "rubygems"
require "github/markdown"
require "optparse"
require "date"
name = ENV['USER'] || ENV['LOGNAME'] || Etc.getlogin || Etc.getpwuid.name
language = "en"
stylesheets = []
javascripts = []
opts = OptionParser.new
opts.program_name = $0
mode = :gfm
opts.on("-s STYLESHEET_FILENAME","--style STYLESHEET_FILENAME",
        "Specify stylesheet filename."){|v| stylesheets << v}
opts.on("-n YOUR_NAME","--name YOUR_NAME","Specify your name."){|v| name=v}
opts.on("-j JAVASCRIPT_FILENAME","--javascript JAVASCRIPT_FILENAME",
        "Specify JavaScript filename."){|v| javascripts << v}
opts.on("-l LANGUAGE","--language LANGUAGE",String,
        "Specify natural language. Its defalt is 'en'."){|v| language=v[0..1].downcase}
opts.on("-r", "--readme",       "Readme mode (default)."){mode = :markdown}
opts.on("-g", "--gfm",             "GFM mode."){mode = :gfm}
opts.on("-p", "--plaintext", "Plaintext mode."){mode = :plaintext}
opts.on_tail("-h", "--help", "Show this message."){puts opts.to_s.sub(/options/,'options] [filename'); exit}
opts.parse!(ARGV)

title = ARGV[0]

body = GitHub::Markdown.to_html(ARGF.read,mode).gsub(/<pre lang="(.*)"><code>/,'<pre lang="\1"><code class="prettyprint">')

style_lines=""
stylesheets.each{|s| style_lines << "  <link rel=\"stylesheet\" href=\"#{s}\" type=\"text/css\" />\n"}

javascript_lines=""
javascripts.each{|j| javascript_lines << "  <script src=\"#{j}\" type=\"text/javascript\"></script>\n"}

STDOUT << "<!DOCTYPE html>
<html lang=\"#{language}\">
<head>
  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
  <title>#{title}</title>
  <meta name=\"author\" content=\"#{name}\" />
#{style_lines}#{javascript_lines}  <link rel=\"icon\" href=\"favicon.ico\" />
</head>
<body>
#{body}
<hr />
<address>Copyright &#169; #{Date.today.year} #{name}</address>
</body>
</html>
"
# Local variables:
#   compile-command: "./gfm2html.rb --readme -l ja -n 'Takeshi Nishimatsu' -s style.css -j https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js gfm2html.md | tee index.html"
# End:
