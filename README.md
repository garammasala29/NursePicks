# NursePicks
[画像]
NursePicksはWeb上にある看護記事を投稿・閲覧できる看護師向けのサービスです

## 開発環境
- Ruby 3.1.0
- Rails 6.1.6
- Vue.js 3.2.36

## 機能概要

## スクリーンショット
- 投稿する

看護師さんに読んでもらいたい記事、論文、YoutubeなどURLさえあれば手軽に投稿できます。

投稿した記事・論文は他のユーザーから評価され、評価が上がるとより多くのユーザーに注目してもらえます。

（記事を投稿するにはGoogle認証でのアカウント登録が必要です)
- 閲覧する

看護に関する良質な記事や論文を見つけることができます。

記事に「いいね」を押すことができ、「いいね」順に並んでいるので、人気の記事を見つけることが容易です。

## 利用方法
### 環境変数の設定
| 環境変数名 | 説明 |
| --- | --- |
| GOOGLE_ID | GoogleクライアントID |
| GOOGLE_SECRET | Googleクライアント シークレット |
| TWITTER_ID | Twitter API Key |
| TWITTER_SECRET | Twitter API シークレット |

### ユーザー
https://www.nursepicks.jp からご利用いただけます。

### インストール
```
$ git clone https://github.com/garammasala29/NursePicks.git
$ bin/setup
$ bin/rails s
```

### テスト
```
$ bundle exec rspec
```
### Lint
```
$ bin/lint
```
