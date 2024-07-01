import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modeles/Message.dart';
import '../modeles/User.dart';
import '../providers/AuthProvider.dart';
import '../services/MessageService.dart';


class MessagingScreen extends StatefulWidget {
  final int partyId;
  final int recipientId;

  MessagingScreen({required this.partyId, required this.recipientId});

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final _messageController = TextEditingController();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      List<Message> messages = await MessageService.getMessages(widget.partyId, widget.recipientId);
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      print('Failed to load messages: $e');
    }
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    User sender = Provider.of<AuthProvider>(context, listen: false).user!;
    Message message = Message(
      id: 0,
      senderId: sender.id,
      recipientId: widget.recipientId,
      partyId: widget.partyId,
      content: _messageController.text,
      createdAt: DateTime.now().toIso8601String(),
    );

    try {
      await MessageService.sendMessage(message);
      _messageController.clear();
      _loadMessages();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaging'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.content),
                  subtitle: Text('Sent by ${message.senderId} at ${message.createdAt}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Type your message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}