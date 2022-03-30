# sc_ynu_v1

sollution Challenge 2022 at YNU gdsc team.

## 環境構築方法

https://firebase.google.com/docs/flutter/setup?hl=ja&platform=ios
こちらの公式ドキュメントに従って説明します。
1. githubからリポジトリをクローンします。
    git clone https://github.com/hasegawa282/SC-YNU-2022.git sc_ynu_v1
    cd sc_ynu_v1

1. flutter × firebase で開発を行う為、firebaseの登録を行なってください。

以下のページから、個人のgoogleアカウントでログインして、Firebaseプロジェクトを作成してください。
https://firebase.google.com/

1. アプリをFirebaseに登録してください。
    1. Firebaseコンソールの「プロジェクトの概要」ページの中央から開発したい端末(ios)をクリックして設定ワークフローを起動します。
    1. アプリのバンドルIDを入力します。
        例えばiosの場合、XCode内で開いたプロジェクトからバンドルIDを見つけます。
    1. バンドルIDを入力したらGoogleService-Info.plistをインストールします。
    1. flutterの場合は残りのフローは省略して「アプリを登録」をクリックします。

1. Firebase構成ファイルを追加する


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
