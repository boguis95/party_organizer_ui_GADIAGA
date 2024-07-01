import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modeles/Rating.dart';

class RatingService {
  static const String baseUrl = "http://localhost:8080/api/ratings";

  static Future<List<Rating>> getRatings(int partyId) async {
    final response = await http.get(Uri.parse("$baseUrl/party/$partyId"));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Rating>.from(l.map((model) => Rating.fromJson(model)));
    } else {
      throw Exception('Failed to load ratings');
    }
  }

  static Future<Rating> addRating(Rating rating) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rating.toJson()),
    );

    if (response.statusCode == 200) {
      return Rating.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add rating');
    }
  }
}