# 練習用Flutterアプリ

本プログラムはGitHub APIを用いてリポジトリを検索するアプリ。
主な特徴は以下。

## 機能
* リポジトリをキーワード検索できる
* 以下のリポジトリの情報を閲覧できる
  * リポジトリ名
  * オーナーアイコン
  * プロジェクト言語
  * Star 数
  * Watcher 数
  * Fork 数
  * Issue 数
* MaterialデザインでUIを構成

## 開発環境

* Flutter: 3.10.6(latest @7/28)
* Dart: 3.0.6

# 実行方法

srcディレクトリ直下にapi-keys.jsonファイルを作成してください。
フォーマットは以下です。

```
{
    "GITHUB_API_KEY": <<YOUR GITHUB API KEY>>
}
```
その後srcディレクトリにて以下のコマンドを実行することでアプリを起動できます。

```
flutter run --dart-define-from-file=api-keys.json
```

## 備考

本プログラムは練習用です。特に採用応募などは現状検討しておりません。
