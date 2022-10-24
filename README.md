# NursePicks
<img src="https://user-images.githubusercontent.com/69446373/197425370-d10918db-3448-4d28-8c5a-cedf92a1fd18.png" width="60%">

**NursePicksはWeb上にある看護記事を投稿・閲覧できる看護師向けのサービスです**

## 概要
**【投稿者】**  
Google、もしくはTwitterのアカウントがあれば、ユーザー登録でき、記事の投稿ができます。  
投稿した記事・論文が他のユーザーから評価され、評価が上がると多くのユーザーに注目されることになります。  
記事に対してコメントをしたり、いいねをすることができます。

**【閲覧者】**  
アカウントなしでもサイトを閲覧することができ、サイト外のリンクへと飛ぶことができます。  
記事に付けられたコメントも読むことができます。  
検索窓から。

## スクリーンショット

### トップ画面
記事の一覧を見ることができ、人気順・新着順で記事を探すことができます  
ログインしていれば、各記事にいいねをすることができます

<img src="https://user-images.githubusercontent.com/69446373/197425585-03cae99c-0d09-4f22-96c7-aa24cb21b58f.png" width="50%">

### 記事投稿画面

モーダル画面から記事のURLを入力

<img src="https://user-images.githubusercontent.com/69446373/197425635-91bbdc79-a44f-4358-827c-66f3ffdd9840.png" width="50%">

### 記事詳細画面

ログインしていれば、コメントやいいねができます

<img src="https://user-images.githubusercontent.com/69446373/197427608-389be1aa-e01a-427f-a7e5-e4e60d7d511f.png" width="50%">

### ユーザー画面

ユーザーの投稿記事・コメント・いいねした記事を確認することができます

<img src="https://user-images.githubusercontent.com/69446373/197437038-b1a4ae6e-0fda-47fb-b8e7-12dd53d9cdcf.png" width="50%">

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
