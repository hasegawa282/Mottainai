import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/Login/index.dart';
import '/pages/Home/index.dart';
import '/pages/Fridge/index.dart';

void main() async {
  // 初期化処理を追加
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseUserのログイン状態が確定するまで待つ
  await FirebaseAuth.instance.userChanges().first;
  // 最初に表示するWidget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final auth = FirebaseAuth.instance;
    bool _checkLogin() {
      return !(auth.currentUser == null);
    }

    return MaterialApp(
        // アプリ名
        title: 'SC-YNU-2022',
        theme: ThemeData(
          // テーマカラー
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: (_checkLogin() == true ? '/home' : '/login'),
        routes: <String, WidgetBuilder>{
          '/login': (context) => const LoginPage(),
          '/home': (context) => HomePage(user: auth.currentUser!),
          '/fridge': (context) => FridgePage(user: auth.currentUser!),
        });
  }
}
