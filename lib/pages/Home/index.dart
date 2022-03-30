import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../dialogs/AddRecipeDialog.dart';
import '../../components/molucules/SCFooter.dart';
import '../../components/molucules/SCHeader.dart';
import '/models/recipe.api.dart';
import '/models/recipe.dart';
import '/pages/Widgets/recipe_card.dart';

// ホーム画面用Widget

class HomePage extends StatefulWidget {
  // ユーザー情報
  final User? user;
  const HomePage({Key? key, required this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipes> _recipes;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      isLoading = false;
    });
  }

  // 起動時に1度だけ発火
  // @override
  // void initState() {
  //   super.initState();
  //   getIngredients();
  //   getRecipes();
  // }
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: SCHeader(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  title: _recipes[index].name,
                  cookTime: _recipes[index].totalTime,
                  rating: _recipes[index].rating.toString(),
                  thumbnailUrl: _recipes[index].images,
                );
              },
            ),
      floatingActionButton: AddRecipeDialog(user: widget.user!),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SCFooter(),
    );
  }
}
