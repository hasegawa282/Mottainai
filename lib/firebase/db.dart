// import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

// Ingredientクラス
class Ingredient {
  String? ingredientName;
  int stock;
  DateTime expiresDate;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  Ingredient({
    required this.ingredientName, 
    required this.stock,
    required this.expiresDate, 
    required this.userId, 
    required this.createdAt, 
    required this.updatedAt, 
    this.deletedAt
  });
   //Firebaseからデータを取得する際の変換処理
  Ingredient.fromJson(Map<String, Object?> json)
      : this(
            ingredientName: json['ingredientName']! as String,
            stock: json['stock']! as int,
            expiresDate: (json['expiresDate']! as Timestamp).toDate(),
            userId: json['userId'] as String,
            createdAt: (json['createdAt']! as Timestamp).toDate(),
            updatedAt: (json['updatedAt']! as Timestamp).toDate(),
            deletedAt: (json['deletedAt'] as Timestamp?)?.toDate(),
    );

  //DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, Object?> toJson() {
    Timestamp? deletedTimestamp;
    if (deletedAt != null) {
      deletedTimestamp = Timestamp.fromDate(deletedAt!);
    }
    return {
      'ingredientName': ingredientName,
      'stock': stock,
      'expiresDate': Timestamp.fromDate(expiresDate),
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedTimestamp,
    };
  }
}
///
/// 食材を扱うリポジトリ
///

class IngredientRepository {
  CollectionReference ingredients = FirebaseFirestore.instance.collection('ingredients');
  // 食材を登録する関数
  Future<String> insert(Ingredient ingredient) async {
    final data = await ingredients.add(ingredient.toJson());
    return data.id;
  }

  // 食材を更新する関数
  Future<String> update(String docId, Map<String, Object?> json) async {
    await ingredients.doc(docId).update(json);
    return docId;
  }

  // 食材を削除する関数
  Future<String> delete(String docId) async {
    await ingredients.doc(docId).delete();
    return docId;
  }

  // 食材を取得する関数
  Future<List<QueryDocumentSnapshot<Ingredient>>> getIngredients({
    required String userId,
  }) async {
    final ingredientRef = ingredients.withConverter<Ingredient>(
      fromFirestore: (snapshot, _) => Ingredient.fromJson(snapshot.data()!),
      toFirestore: (ingredient, _) => ingredient.toJson(),
    );
    // ログインしているユーザーIDと一致する食材だけ取得する。
    final ingredientSnapshot = await ingredientRef.where('userId', isEqualTo: userId).get();
    return ingredientSnapshot.docs;
  }
}

// Recipeクラス
class Recipe {
  String recipeName;
  String userId;
  List<String> ingredients;
  String? imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  Recipe({
    required this.recipeName, 
    required this.ingredients,
    this.imageUrl, 
    required this.userId, 
    required this.createdAt, 
    required this.updatedAt, 
    this.deletedAt
  });
   //Firebaseからデータを取得する際の変換処理
  Recipe.fromJson(Map<String, Object?> json)
      : this(
            recipeName: json['recipeName']! as String,
            ingredients: json['ingredients']! as List<String>,
            userId: json['userId'] as String,
            createdAt: (json['createdAt']! as Timestamp).toDate(),
            updatedAt: (json['updatedAt']! as Timestamp).toDate(),
            imageUrl: json['imageUrl']! as String?,
            deletedAt: (json['deletedAt'] as Timestamp?)?.toDate(),
    );

  //DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, Object?> toJson() {
    Timestamp? deletedTimestamp;
    String? iu;
    if (deletedAt != null) {
      deletedTimestamp = Timestamp.fromDate(deletedAt!);
    }
    if(iu != null){
      iu = imageUrl;
    }
    return {
      'recipeName': recipeName,
      'ingredients': ingredients,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'imageUrl': iu,
      'deletedAt': deletedTimestamp,
    };
  }
}

///
/// レシピを扱うリポジトリ
///

class RecipeRepository {
  CollectionReference recipes = FirebaseFirestore.instance.collection('recipes');
  // レシピを登録する関数
  Future<String> insert(Recipe recipe) async {
    final data = await recipes.add(recipe.toJson());
    return data.id;
  }

  // レシピを更新する関数
  Future<String> update(String docId, Map<String, Object?> json) async {
    await recipes.doc(docId).update(json);
    return docId;
  }

  // レシピを削除する関数
  Future<String> delete(String docId) async {
    await recipes.doc(docId).delete();
    return docId;
  }

  // レシピを取得する関数
  Future<List<QueryDocumentSnapshot<Recipe>>> getRecipes() async {
    final recipeRef = recipes.withConverter<Recipe>(
      fromFirestore: (snapshot, _) => Recipe.fromJson(snapshot.data()!),
      toFirestore: (recipe, _) => recipe.toJson(),
    );
    final recipeSnapshot = await recipeRef.get();
    return recipeSnapshot.docs;
  }
}