# sc_ynu_v1

sollution Challenge 2022 at YNU gdsc team.

## 方針
flutter × firebaseで開発を行います。
それぞれが自由な環境を使えるように、個人でfirebaseでプロジェクトを作ります。

## 環境構築方法

https://firebase.google.com/docs/flutter/setup?hl=ja&platform=ios
こちらの公式ドキュメントに従って説明します。
1. githubからリポジトリをクローンします。
    git clone https://github.com/hasegawa282/Mottainai.git sc_ynu_v1
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
    1. ダウンロードしたGoogleService-Info.plistをisoであれば、ios/Runner/Runnerディレクトリに移動します。
        ※iosの場合は必ずXcodeを使用してください。androidの場合は、ワークフローに従ってください。

1. firebase CLIインストール
    https://firebase.google.com/docs/cli?hl=ja
    1. firebase CLIをインストールします
        以下どちらかのコマンドでインストールしてください。
        ※windowsはnpmの方のみ。macOSはどちらでもOK
        ```console
        curl -sL https://firebase.tools | bash
        npm install -g firebase-tools

        ```
    1. 各自のGoogleアカウントでfirebaseにログインする。
        ```console
        firebase login
        ```
    1. インストールとログインができたかテスト
        ```console
        firebase projects:list
        ```
        うまくいけばfirebaseコンソールと同じFirebaseプロジェクトが表示されるはず。

1. flutterfire CLI インストール
    https://firebase.flutter.dev/docs/overview/
    1. flutterfire cliをインストール
        ```console
        dart pub global activate flutterfire_cli
        ```

        #### うまくいかない場合
        メッセージにパスの通し方が表示されると思いますので、それに従ってパスを通してください。
        下はmacOSのzshを使用している場合です。
        ```console
        export PATH="$PATH":"$HOME/.pub-cache/bin"
        ```
        パスを通したら再度flutterfire cliをインストールします。
        ```console
        dart pub global activate flutterfire_cli
        ```
    2. flutterfireの認証を行います。
        ```console
        flutterfire configure
        ```
        多分文章通りに進めていけばできると思います。
        ※windowsの場合は、macOS, iosのチェックを外してください(おそらく対応できずエラーが起きるので)

上記の操作で必要なインストールは完了します。以下では実際にローカル立ち上げを行います。

1. pubspec.yamlのライブラリをインストールする
    ```console
        dart pub get
    ```

1. ローカル立ち上げ
    ```console
        flutter run
    ```
1. version系のエラーが出る場合は
    ```console
        flutter channel dev
    ```
    でチャンネルを変更すると動くっぽいです。

## その他
 - 新しいライブラリインストール方法
    ```console
        flutter pub add <ライブラリ名>
    ```
 - yummly2のレシピを表示したい場合
    ホーム画面でサンプルレシピが表示されますが、これを行うためにはRakuten Rapid APIのyummly2のapi keyを取得する必要があります。
    https://api.rakuten.net/apidojo/api/yummly2/pricing

    取得したapi keyを環境変数に指定することで使用できます。
    仮にapi key = '123456'だとすると
    ```console
        flutter run --dart-define=YUMMY_API_KEY='123456'
    ```
    として立ち上げてください。
    YUMMY_API_KEYという名前を環境変数としています。

## 開発の進め方
 githubでそれぞれ、新しいブランチを切ってください。
 タスクが完了したら、新しいブランチでgit pushを行い、developブランチにプルリクエストをしてください。
