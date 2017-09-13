Railsアプリケーション作成時のテンプレートレポジトリ　

Rails ver 4.2.3 / ruby ver 2.3.0

使用する際は下記の手順で

① git clone

$`git clone git@github.com:a-kubotera/RailsTemplate4.2.3` [アプリ名]

② ディレクトリ移動

$`cd [新しいアプリ名]`

③ gitを一旦削除

$`rm -rf .git/`<br>
$`git init`

④ データベースのリネーム

~~~
#.envに以下を記載

DATABASENAME="[データベース名]"
~~~

⑤ bundle install

$`be bundle install --path vendor/bundle`

⑥？？？

$`spring stop`<br>
$`bin/spring`<br>

⑦ データベース作成

$`be rake db:create db:migrate`

一通りの設定は完了。

### マテリアルアイコンの使用方法<br>
~~~
 <%= material_icon.home.md_36 %><br>
 <%= mi.face %>
~~~

### Twitterアイコンの使い方
~~~
<%=fa_icon "twitter" %>
<i class="fa fa-twitter"></i>

<%fa_icon "twitter", text: "Twitter" %>
<i class="fa fa-twitter"></i> Twitter
~~~
