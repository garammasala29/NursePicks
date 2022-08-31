# NursePicks
<img src="https://user-images.githubusercontent.com/69446373/187741647-8ee65914-66fc-4eab-be0f-8947501d4ebe.png" width="60%">

**NursePicksはWeb上にある看護記事を投稿・閲覧できる看護師向けのサービスです**

## 概要
**【投稿者】**

Google、もしくはTwitterのアカウントがあれば、ユーザー登録でき、記事の投稿ができます

投稿した記事・論文が他のユーザーから評価され、評価が上がると多くのユーザーに注目されることになります

記事に対してコメントをしたり、いいねをすることができます

**【閲覧者】**

アカウントなしでもサイトを閲覧することができ、サイト外のリンクへと飛ぶことができます

記事に付けられたコメントも読むことができます

## スクリーンショット

### トップ画面
記事の一覧を見ることができ、人気順・新着順で記事を探すことができます

ログインしていれば、各記事にいいねをすることができます

<img src="https://user-images.githubusercontent.com/69446373/187743218-0a101679-cc16-450f-aac1-0eb5e35cb8c2.png" width="50%">

### 記事投稿画面

モーダル画面から記事のURLを入力

<img src="https://user-images.githubusercontent.com/69446373/187744542-0a303d14-edeb-48fb-aba3-e0aaa8fa9f72.png" width="50%">

### 記事詳細画面

ログインしていれば、コメントやいいねができます

<img src="https://user-images.githubusercontent.com/69446373/187747175-3b067911-0977-4663-9eb2-ade54206513f.png" width="50%">


### ユーザー画面

ユーザーの投稿記事・コメント・いいねした記事を確認することができます

<img src="https://user-images.githubusercontent.com/69446373/187746586-c9809170-4738-4cdf-a49b-6cd05feae6a7.png" width="50%">

## 利用方法

### ユーザー
https://www.nursepicks.jp からご利用いただけます。

### インストール
```
$ git clone https://github.com/garammasala29/NursePicks.git
$ bin/setup
$ bin/rails s
```

### 環境変数の設定

| 環境変数名 | 説明 |
| --- | --- |
| GOOGLE_ID | GoogleクライアントID |
| GOOGLE_SECRET | Googleクライアント シークレット |
| TWITTER_ID | Twitter API Key |
| TWITTER_SECRET | Twitter API シークレット |

## 開発環境
- Ruby 3.1.0
- Rails 6.1.6
- Vue.js 3.2.36

## テスト
```
$ bundle exec rspec
```
## Lint
```
$ bin/lint
```
実行されるlint

- Ruby
  - rubocop
  - slim-lint
- JavaScript
  - eslint
  - prettier
