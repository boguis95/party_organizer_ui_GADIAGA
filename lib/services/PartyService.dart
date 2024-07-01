import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modeles/Party.dart';


class PartyService {
  static const String baseUrl = "http://172.20.10.7:8081/api/parties";

  static Future<List<Party>> getParties() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Party>.from(l.map((model) => Party.fromJson(model)));
    } else {
      throw Exception('Failed to load parties');
    }
  }

  static Future<void> createParty(Party party) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(party.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create party');
    }
  }

  static Future<void> updateParty(int id, Party party) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(party.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update party');
    }
  }

  static Future<void> deleteParty(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete party');
    }
  }

  static Future<void> participateInParty(int partyId, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$partyId/participate'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userId),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to participate in party');
    }
  }


  static Future<List<Party>> searchParties({
    String city = '',
    String partyType = '',
    int maxPeople = 0,
    bool isPaid = false,
    String time = '',
  }) async {
    final queryParameters = {
      'city': city.isNotEmpty ? city : null,
      'partyType': partyType.isNotEmpty ? partyType : null,
      'maxPeople': maxPeople > 0 ? maxPeople.toString() : null,
      'isPaid': isPaid.toString(),
      'time': time.isNotEmpty ? time : null,
    };

    final uri = Uri.http(
      '172.20.10.7:8081', // Remplacez par votre adresse IP locale
      '/api/parties/search',
      queryParameters..removeWhere((key, value) => value == null), // Remove null values
    );

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Party>.from(l.map((model) => Party.fromJson(model)));
    } else {
      throw Exception('Failed to load parties');
    }
  }

}