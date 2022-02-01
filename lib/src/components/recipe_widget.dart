import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recipe_book/src/api/recipe.api.dart';
import 'package:recipe_book/src/model/recipe.dart';

class RecipeWidget extends StatelessWidget {
  Recipe recipe;
  RecipeWidget(this.recipe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Card(
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.images),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.black.withOpacity(0.35),
                child: ListTile(
                  title: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white,),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        )
                      ];
                    },
                    onSelected: (String value) => actionPopUpItemSelected(value, context),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }


  Future<void> actionPopUpItemSelected(String value, BuildContext context) async {
    String message;
    if (value == 'edit') {
      editRecipe(value, context);
    } else if (value == 'delete') {
      deleteRecipe(value, context);
    }
  }

  void _showSnackBar(String message, BuildContext context, {Color backColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backColor,
      ),
    );
  }

  Future<void> deleteRecipe(String value, BuildContext context) async {

    final deletedRecipe = await RecipeApi.deleteRecipe(recipe.id.toString());

    if (deletedRecipe) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Recipe deleted successfully"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, "/");
                      },
                    child: const Text("OK"))
              ],
            );
          });
    } else {
      _showSnackBar("The recipe was not deleted correctly", context);
    }

  }

  void editRecipe(String value, BuildContext context) {
    Navigator.of(context).pushNamed("/edit_recipe", arguments: recipe);
  }
  
}