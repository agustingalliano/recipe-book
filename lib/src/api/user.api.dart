import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_book/src/models/user.dart';
import 'package:recipe_book/src/utilities//constants.dart';

class UserApi {

  static Future<bool> login(String username, String password) async {

    Map data = {
      'username': username,
      'password': password
    };
    var body = json.encode(data);

    final http.Response response = await http.post(
      Uri.parse(Constants.URI+'/users/login'),
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response.statusCode == Constants.STATUS_OK;

  }

}