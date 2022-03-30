import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///
/// Header
///
class SCHeader extends StatelessWidget with PreferredSizeWidget {
  SCHeader({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Mottainai'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            // ログアウト処理
            // 内部で保持しているログイン情報等が初期化される
            // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
            await FirebaseAuth.instance.signOut();
            // ログイン画面に遷移＋チャット画面を破棄
            await Navigator.pushNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
