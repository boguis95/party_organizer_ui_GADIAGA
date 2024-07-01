import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modeles/User.dart';

class AuthService {
  static const String baseUrl = "http://172.20.10.7:8081/api/auth";

  static Future<User> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login user');
    }
  }

  static Future<User> registerUser(User user) async {
   try{
     final response = await http.post(
       Uri.parse("$baseUrl/signup"),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode(user.toJson()),
     );

     if (response.statusCode == 200) {
       return User.fromJson(jsonDecode(response.body));
     } else {
       throw Exception('Failed to register user');
     }
   }catch(error){
     print('Error: $error');
    throw error;
   }
  }
}