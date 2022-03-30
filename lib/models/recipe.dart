class Recipes {
  final String name;
  final String images;
  final double rating;
  final String totalTime;

  Recipes({required this.name, required this.images, required this.rating, required this.totalTime});

  factory Recipes.fromJson(dynamic json) {
    return Recipes(
        name: json['name'] as String,
        images: json['images'][0]['hostedLargeUrl'] as String,
        rating: json['rating'] as double,
        totalTime: json['totalTime'] as String);
  }

  static List<Recipes> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipes.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime}';
  }
}