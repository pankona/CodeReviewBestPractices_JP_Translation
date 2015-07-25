#!/bin/sh

./gfm2html.rb -s ./screen.css -g -n pankona ./translated.md > index.html

tmpfile=$(mktemp 2>/dev/null||mktemp -t tmp)
cat ./index.html | sed -e "s/<title>\.\/translated\.md<\/title>/<title>Code Review Best Practices 日本語翻訳<\/title>/g" > $tmpfile
cp $tmpfile index.html
rm $tmpfile
  
