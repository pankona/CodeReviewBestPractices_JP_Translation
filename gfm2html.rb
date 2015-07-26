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
title = ARGV[0]
language = "en"
stylesheets = []
javascripts = []
opts = OptionParser.new
opts.program_name = $0
mode = :gfm
opts.on("-s STYLESHEET_FILENAME","--style STYLESHEET_FILENAME",
        "Specify stylesheet filename."){|v| stylesheets << v}
opts.on("-n YOUR_NAME","--name YOUR_NAME","Specify your name."){|v| name=v}
opts.on("-t PAGE_TITLE","--title PAGE_TITLE","Specify page title."){|v| title=v}
opts.on("-j JAVASCRIPT_FILENAME","--javascript JAVASCRIPT_FILENAME",
        "Specify JavaScript filename."){|v| javascripts << v}
opts.on("-l LANGUAGE","--language LANGUAGE",String,
        "Specify natural language. Its defalt is 'en'."){|v| language=v[0..1].downcase}
opts.on("-r", "--readme",       "Readme mode (default)."){mode = :markdown}
opts.on("-g", "--gfm",             "GFM mode."){mode = :gfm}
opts.on("-p", "--plaintext", "Plaintext mode."){mode = :plaintext}
opts.on_tail("-h", "--help", "Show this message."){puts opts.to_s.sub(/options/,'options] [filename'); exit}
opts.parse!(ARGV)

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
<a href=\"http://b.hatena.ne.jp/entry/http://pankona.github.io/CodeReviewBestPractices_JP_Translation/\" class=\"hatena-bookmark-button\" data-hatena-bookmark-title=\"Code Review Best Practices 日本語訳\" data-hatena-bookmark-layout=\"simple-balloon\" title=\"このエントリーをはてなブックマークに追加\"><img src=\"https://b.st-hatena.com/images/entry-button/button-only@2x.png\" alt=\"このエントリーをはてなブックマークに追加\" width=\"20\" height=\"20\" style=\"border: none;\" /></a><script type=\"text/javascript\" src=\"https://b.st-hatena.com/js/bookmark_button.js\" charset=\"utf-8\" async=\"async\"></script><a href=\"https://twitter.com/share\" class=\"twitter-share-button\" data-url=\"http://pankona.github.io/CodeReviewBestPractices_JP_Translation/\" data-text=\"Code Review Best Practices 日本語訳\">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>

<address>Copyright &#169; #{Date.today.year} #{name}</address>
</body>
</html>
"
# Local variables:
#   compile-command: "./gfm2html.rb --readme -l ja -n 'Takeshi Nishimatsu' -s style.css -j https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js gfm2html.md | tee index.html"
# End:
