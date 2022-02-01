import 'package:flutter/material.dart';
import 'package:recipe_book/src/components/recipe_widget.dart';
import 'package:recipe_book/src/screens/add_recipe_page.dart';
import 'package:recipe_book/src/screens/edit_recipe_page.dart';
import 'package:recipe_book/src/screens/home_page.dart';
import 'package:recipe_book/src/screens/login_page.dart';

import 'models/recipe.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan[300],
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/home":
              return HomePage(context);
            case "/add_recipe":
              return AddRecipePage(context);
            case "/edit_recipe":
              Recipe recipe = settings.arguments as Recipe;
              return EditRecipePage(recipe, context);
            case "/login":
              return LoginPage(context);
            default:
              return LoginPage(context);
          }
        });
      },
    );
  }
}