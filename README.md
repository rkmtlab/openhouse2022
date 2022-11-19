# rkmtlab.github.io/openhouse2016
## Getting started

1. Clone this repository: `git clone git@github.com:rkmtlab/openhouse2016.git`
2. Install Sass via rubygems: `bundle install`
3. Compile stylesheets: `sass -r sass-globbing assets/styles/style.scss build`
4. Run web server: `ruby -run -e httpd . -p 8000`
5. Open with your web browser: [localhost:8000](http://localhost:8000)

## Tips
Compiled stylesheets are generetad ./ directory.
So the below one is better for use.
`sass -r sass-globbing assets/styles/style.scss build/style.css`

## 背景画像の変更

1. まず、asstes/images/projectsとその下の/mobileに画像を入れます。この時、同じプロジェクトは同じ名前の画像ファイルにします
2.  generate_background_css.shで下の二つを必要に応じて変更します(今は6秒で消えて、3秒オーバーラップする)
       -  #1枚の画像が出てから消えるまでの時間
       -  animation_length_in_second=6
       -  #どれぐらいオーバーラップするか
       -  animation_overlap_length_in_second=3  
3. sh generate_background_css.sh でCSSを生成します
     - そしてbuild/style.cssを変更します。(↓この場所です)
       - /\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/
       - /* ここからbackground CSS */
       - /\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/
4. generate_background_css.shのコメントアウト場所を変えてhtmlを出力します
       - #下のコメントアウトを解除するとindex.htmlに出力するものが出てくる
        - #echo "<div id=\"bg-$image_file_name_prefix\"></div>"
5. 最後にindex.htmlを編集します