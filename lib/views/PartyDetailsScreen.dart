import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modeles/Party.dart';
import '../modeles/User.dart';
import '../providers/AuthProvider.dart';
import '../services/PartyService.dart';
import 'message_screen.dart';

class PartyDetailsScreen extends StatefulWidget {
  @override
  _PartyDetailsScreenState createState() => _PartyDetailsScreenState();
}

class _PartyDetailsScreenState extends State<PartyDetailsScreen> {
  late Party party;
  late User user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    party = ModalRoute.of(context)!.settings.arguments as Party;
    user = Provider.of<AuthProvider>(context, listen: false).user!;
  }

  void _participateInParty() async {
    try {
      await PartyService.participateInParty(party.id, user.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request to participate sent')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to send request')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(party.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Location: ${party.location}'),
            Text('Type: ${party.type}'),
            Text('Date: ${party.date}'),
            Text('Time: ${party.time}'),
            Text('Remaining Slots: ${party.remainingSlots}/${party.maxParticipants}'),
            Text('Price: ${party.paid ? party.price.toString() : 'Free'}'),
            ElevatedButton(
              onPressed: _participateInParty,
              child: Text('Participate'),
            ),
            SizedBox(height: 5.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagingScreen(
                      partyId: party.id,
                      recipientId: party.organizerId,
                    ),
                  ),
                );
              },
              child: Text('Message Organizer'),
            )
            // Add more details and participant list here
          ],
        ),
      ),
    );
  }
}