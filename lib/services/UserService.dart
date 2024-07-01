import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modeles/User.dart';


class UserService {
  static const String baseUrl = "http://localhost:8080/api/users";

  static Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<User>.from(l.map((model) => User.fromJson(model)));
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  static Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}