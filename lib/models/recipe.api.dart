import 'dart:convert';
import '/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipes>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "24", "start": "0", "tag": "list.recipe.popular"});
    List _temp = [];
    const apiKey = String.fromEnvironment("YUMMY_API_KEY");
    if (apiKey.isNotEmpty) {
      final response = await http.get(uri, headers: {
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
        "x-rapidapi-key": apiKey,
        "useQueryString": "true"
      });
      Map data = jsonDecode(response.body);
      for (var i in data['feed']) {
        _temp.add(i['content']['details']);
      }
    }

    return Recipes.recipesFromSnapshot(_temp);
  }
}
