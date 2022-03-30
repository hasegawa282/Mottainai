import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../firebase/db.dart';

class AddRecipeDialog extends StatefulWidget {
  // ユーザー情報
  final User user;
  final Function? onFinish;
  const AddRecipeDialog({Key? key, required this.user, this.onFinish}) : super(key: key);
  @override
  _AddRecipeDialogState createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  String recipeName = '';
  // 現状3で固定 [Todo] 入力フィールドの数を調整できるように
  List<String> ingredients = List.generate(3, (i) => '');

  Future<void> addRecipeDialog(BuildContext context) async {
    //処理が重い(?)からか、非同期処理にする
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('add recipe'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // レシピの名前を入力
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'recipe name'),
                      onChanged: (String value) {
                        setState(() {
                          recipeName = value;
                        });
                      },
                    ),

                    TextFormField(
                      decoration: const InputDecoration(labelText: 'ingredient1'),
                      keyboardType: TextInputType.multiline,
                      onChanged: (String value) {
                        setState(() {
                          var newIngredients = [...ingredients];
                          newIngredients[0] = value;
                          ingredients = newIngredients;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'ingredient2'),
                      keyboardType: TextInputType.multiline,
                      onChanged: (String value) {
                        setState(() {
                          var newIngredients = [...ingredients];
                          newIngredients[1] = value;
                          ingredients = newIngredients;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'ingredient3'),
                      keyboardType: TextInputType.multiline,
                      onChanged: (String value) {
                        setState(() {
                          var newIngredients = [...ingredients];
                          newIngredients[2] = value;
                          ingredients = newIngredients;
                        });
                      },
                    ),
                    // 材料を入力
                    // ListView.builder(
                    //   itemCount: ingredients.length,
                    //   itemBuilder: (BuildContext context, int index){
                    //     return TextFormField(
                    //       decoration: InputDecoration(labelText: 'ingredient${index+1}'),
                    //       onChanged: (String value) {
                    //         setState(() {
                    //           if(index < 0 || index >= ingredients.length){
                    //             return;
                    //           }
                    //           var newIngredients = [...ingredients];
                    //           newIngredients[index] = value;
                    //         });
                    //       },
                    //     );
                    //   }
                    // ),
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
                      // 存在している文字列のみ抽出
                      List<String> filter = ingredients.where((String value) => value.isNotEmpty).toList();
                      //OKを押したあとの処理
                      if (recipeName.isEmpty) {
                        print("食品名を入力してください");
                        return;
                      }
                      if (filter.isEmpty) {
                        print("登録数は1以上の整数です。");
                        return;
                      }
                      final recipeRepository = RecipeRepository();
                      DateTime now = DateTime.now();
                      // 登録する食材データ
                      final insertRecipe = Recipe(
                        recipeName: recipeName,
                        userId: widget.user.uid,
                        ingredients: filter,
                        createdAt: now,
                        updatedAt: now,
                      );
                      recipeRepository.insert(insertRecipe);
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
        Icons.menu_book,
      ),
      onPressed: () {
        addRecipeDialog(context);
      },
      padding: const EdgeInsets.all(24),//パディング
      color: Colors.blueGrey, //背景色
      textColor: Colors.white, //アイコンの色
      shape: const CircleBorder(),//丸
      
    );
  }
}
