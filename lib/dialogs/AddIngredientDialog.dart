import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../firebase/db.dart';

class AddIngredientDialog extends StatefulWidget {
  // ユーザー情報
  final User user;
  final Function? onFinish;
  const AddIngredientDialog({Key? key, required this.user, this.onFinish}) : super(key: key);
  @override
  _AddIngredientDialogState createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  String ingredientName = '';
  int stock = 1;
  DateTime? expiresDate;
  Future _pickDate(BuildContext context, setState) async {
    //DatePickerの初期値
    final initialDate = DateTime.now();
    //DatePickerを表示し、選択されたら変数に格納する
    final newDate = await showDatePicker(
        context: context,
        //初期値を設定
        initialDate: initialDate,
        //選択できる日付の上限
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime(DateTime.now().year + 2));

    //nullチェック
    if (newDate != null) {
      //選択された日付を変数に格納
      setState(() => expiresDate = newDate);
    } else {
      //nullならば何もしない
      return;
    }
  }

  Future<void> addFoodDialog(BuildContext context) async {
    //処理が重い(?)からか、非同期処理にする
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('add ingredients'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 食べ物の名前を入力
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'ingredient name'),
                      onChanged: (String value) {
                        setState(() {
                          ingredientName = value;
                        });
                      },
                    ),
                    // 在庫数を入力
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'stock'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (String value) {
                        setState(() {
                          stock = int.parse(value);
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () => _pickDate(context, setState),
                        child: const Text("Pick expiresDate")),
                    Row(
                      // const DateTime? ed = expiresDate,
                      children: [
                        const Text('expiresDate : '),
                        Text(expiresDate == null
                            ? ''
                            : DateFormat('yyyy/M/d').format(expiresDate!)),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      print('click');
                      //OKを押したあとの処理
                      if (ingredientName.isEmpty) {
                        print("食品名を入力してください");
                        return;
                      }
                      if (stock < 1) {
                        print("登録数は1以上の整数です。");
                        return;
                      }
                      DateTime? ed = expiresDate;
                      if (ed is! DateTime) {
                        print("消費期限を入力してください");
                        return;
                      }
                      final ingredientRepository = IngredientRepository();
                      DateTime now = DateTime.now();
                      // 登録する食材データ
                      final insertIngredient = Ingredient(
                        ingredientName: ingredientName,
                        userId: widget.user.uid,
                        stock: stock,
                        expiresDate: ed,
                        createdAt: now,
                        updatedAt: now,
                      );
                      ingredientRepository.insert(insertIngredient);
                      final onF = widget.onFinish;
                      // onFinishが存在していれば関数を発動
                      if(onF != null){
                        onF();
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: const Icon(
        Icons.fastfood,
      ),
      onPressed: () {
        addFoodDialog(context);
      },
      padding: const EdgeInsets.all(24),//パディング
      color: Colors.blueGrey, //背景色
      textColor: Colors.white, //アイコンの色
      shape: const CircleBorder(),//丸
      
    );
  }
}
