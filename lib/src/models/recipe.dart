class Recipe {

  final int id;
  final String name;
  final String images;
  final String description;

  Recipe(this.id, this.name, this.images, this.description);

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        json['id'] as int,
        json['name'] as String,
        json['image'] as String,
        json['description'] as String
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Recipe{id: $id, name: $name, image: $images, description: $description}';
  }
}