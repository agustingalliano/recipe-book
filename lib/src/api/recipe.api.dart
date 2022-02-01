import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_book/src/models/recipe.dart';
import 'package:recipe_book/src/utilities/constants.dart';

class RecipeApi {

  static Future<List<Recipe>> getRecipes() async {

    var url = Uri.parse(Constants.URI+'/recipes');
    final response =  await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});
    List data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }

    return Recipe.recipesFromSnapshot(_temp);

  }

  static Future<bool> createRecipe(Recipe recipe) async {
    var url = Uri.parse(Constants.URI+'/recipes');

    Map data = {
      'name': recipe.name,
      'description': recipe.description,
      'image': recipe.images
    };
    var body = json.encode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json", "Access-Control-Allow-Origin": "*"}, body:body);

    return response.statusCode == Constants.STATUS_CREATED;
  }

  static Future<bool> deleteRecipe(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(Constants.URI+'/recipes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response.statusCode == Constants.STATUS_OK;
  }

  static Future<bool> editRecipe(Recipe recipe) async {

    Map data = {
      'name': recipe.name,
      'description': recipe.description,
      'image': recipe.images
    };
    var body = json.encode(data);

    final id = recipe.id;

    final http.Response response = await http.put(
      Uri.parse(Constants.URI+'/recipes/$id'),
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response.statusCode == Constants.STATUS_CREATED;

  }
}