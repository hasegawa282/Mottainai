import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../dialogs/AddIngredientDialog.dart';
import '../../firebase/db.dart';
import '../../components/molucules/SCFooter.dart';
import '../../components/molucules/SCHeader.dart';

// 冷蔵庫用Widget

class FridgePage extends StatefulWidget {
  // ユーザー情報
  final User? user;
  const FridgePage({Key? key, required this.user}) : super(key: key);
  @override
  _FridgePageState createState() => _FridgePageState();
}
class _FridgePageState extends State<FridgePage>{
  // 表示する食材データのリスト
  List<QueryDocumentSnapshot<Ingredient>> ingredients = [];

  Future<void> getIngredients() async {
    if(widget.user != null){
      final ingredientRepository = IngredientRepository();
      final s = await ingredientRepository.getIngredients(userId: widget.user?.uid as String);
      // List<QueryDocumentSnapshot<Ingredient>> ins = [];
      setState((){
        ingredients = s;
      });
    }
  }

  // 起動時に1度だけ発火
  @override
  void initState() {
    super.initState();
    getIngredients();
  }
  @override
  Widget build(BuildContext context, ){
        return Scaffold(
          appBar: SCHeader(),
          body: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                Ingredient ingredient = ingredients[index].data();
                String docId = ingredients[index].id;
                return Container(
                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                  height: 140,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text('${ingredient.ingredientName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('expiresDate: ${DateFormat('yyyy/MM/dd').format(ingredient.expiresDate)}'),

                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('stock: ${ingredient.stock}'),
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () async{
                                              final ingredientRepository = IngredientRepository();
                                              // 在庫が1以下の時はデータごと削除
                                              if(ingredient.stock <= 1){
                                                ingredientRepository.delete(docId);
                                              }else{ // 在庫が2以上では1つ減らす
                                                ingredientRepository.update(docId, {
                                                'stock': ingredient.stock - 1,
                                              });
                                              }
                                              // DBを更新したらデータ再取得
                                              getIngredients();
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () async{
                                              // if(ingredient.stock < 1) return;
                                              final ingredientRepository = IngredientRepository();
                                              ingredientRepository.update(docId, {
                                                'stock': ingredient.stock + 1,
                                              });
                                              // DBを更新したらデータ再取得
                                              getIngredients();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                );
              }
          ),
          floatingActionButton: AddIngredientDialog(user: widget.user!, onFinish: getIngredients),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const SCFooter(),
        );
  }
}