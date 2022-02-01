import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/src/components/recipe_widget.dart';
import 'package:recipe_book/src/api/recipe.api.dart';
import 'package:recipe_book/src/models/recipe.dart';

class HomePage extends StatefulWidget {

  const HomePage(context, {Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<HomePage> {

  // late List<Recipe> _recipes;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My cookbook"),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: RecipeApi.getRecipes(),
        builder: (context, snapshot){
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final list = snapshot.data;
            return ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return RecipeWidget(list[index]);
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/add_recipe");
        },
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getRecipes();
  // }
  //
  // Future<void> getRecipes() async {
  //
  //   _recipes = await RecipeApi.getRecipe();
  //   setState(() {
  //     isLoading = false;
  //   });
  //
  //   print(_recipes);
  // }
}