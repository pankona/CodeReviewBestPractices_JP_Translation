
# Code Review Best Practices 日本語訳

## 本リポジトリは

以下のポストを日本語に訳したものを gh-pages に公開しています。  
なお、ご本人には連絡済であり、掲載の許可もいただいています。  
Thank you so much, Kevin-san!  
[Code Review Best Practices - Kevin London's blog](http://kevinlondon.com/2015/05/05/code-review-best-practices.html)

日本語訳したページは以下。  
[Code Review Best Practices 日本語翻訳](http://pankona.github.io/CodeReviewBestPractices_JP_Translation/)

## Contribution

日本語訳がおかしいところや、こうしたほうが分かりやすい、等、  
指摘や提案があれば ISSUE か Pull Request か、その他なんでもいいので教えてくれるととても嬉しいです。

### 主なファイル構成

* index.html

  * generate_html.sh、gfm2html.rb によって自動生成されます。  
    本ファイルは直接更新しません。

* gfm2html.rb

  * markdown → html 変換スクリプトです。

* generate_html.sh

  * `gfm2html.rb` を引数付きで呼び出します。
 
* original.txt

  * 翻訳前の文書です。参考までに。
 
