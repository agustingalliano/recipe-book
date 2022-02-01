import 'dart:io';


import 'package:flutter/material.dart';
import 'package:recipe_book/src/api/recipe.api.dart';
import 'package:recipe_book/src/models/recipe.dart';

class AddRecipePage extends StatefulWidget {
  BuildContext context;

  AddRecipePage(this.context, {Key? key})
      : super(key: key);

  @override
  AddRecipeState createState() => AddRecipeState();
}

class AddRecipeState extends State<AddRecipePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "", description = "", image = "";
  bool saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 60),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan[300]!,
                      Colors.cyan[800]!,
                    ],
                  ),
                ),
                // child: Image.asset('assets/images/logo.png',
                //     color: Colors.white, height: 200),
              ),
              SizedBox(
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                        onPressed: () {
                          if (_formKey.currentState != null) _save(context);
                        },
                        icon: const Icon(Icons.save))
                  ],
                ),
                height: kToolbarHeight + 30,
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -40),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 260, bottom: 40),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 20),
                        child: ListView(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Recipe name: "),
                              onSaved: (value) {
                                name = value!;
                              },
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return "This field is required";
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  labelText: "Description: "),
                              onSaved: (value) {
                                description = value!;
                              },
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return "This field is required";
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Url a imagen: "),
                              onSaved: (value) {
                                image = value!;
                              },
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return "This field is required";
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ));
  }


  void _showSnackBar(String message, {Color backColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backColor,
      ),
    );
  }

  _save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Recipe recipe = Recipe(0, name, image, description);

      final savedRecipe = await RecipeApi.createRecipe(recipe);

      if (savedRecipe) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("Recipe saved successfully"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, "/home");
                      },
                      child: const Text("OK"))
                ],
              );
            });
      } else {
        _showSnackBar("The recipe was not saved correctly");
      }

    }
  }
}
