import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modeles/Participant.dart';

class ParticipantService {
  static const String baseUrl = "http://localhost:8080/api/participants";

  static Future<List<Participant>> getParticipants(int partyId) async {
    final response = await http.get(Uri.parse("$baseUrl/party/$partyId"));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Participant>.from(l.map((model) => Participant.fromJson(model)));
    } else {
      throw Exception('Failed to load participants');
    }
  }

  static Future<Participant> addParticipant(Participant participant) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(participant.toJson()),
    );

    if (response.statusCode == 200) {
      return Participant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add participant');
    }
  }
}