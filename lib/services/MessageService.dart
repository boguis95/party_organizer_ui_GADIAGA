import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modeles/Message.dart';

class MessageService {
  static const String baseUrl = "http://172.20.10.7:8081/api/messages";

  static Future<List<Message>> getMessages(int partyId, int recipientId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$partyId/$recipientId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Message>.from(l.map((model) => Message.fromJson(model)));
    } else {
      throw Exception('Failed to load messages');
    }
  }


  static Future<Message> sendMessage(Message message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 200) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message');
    }
  }
}