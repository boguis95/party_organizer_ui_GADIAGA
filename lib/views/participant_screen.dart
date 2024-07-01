import 'package:flutter/material.dart';

import '../modeles/Participant.dart';
import '../services/ParticipantService.dart';


class ParticipantScreen extends StatelessWidget {
  final int partyId;

  ParticipantScreen({required this.partyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Participants'),
      ),
      body: FutureBuilder<List<Participant>>(
        future: ParticipantService.getParticipants(partyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No participants found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final participant = snapshot.data![index];
                return ListTile(
                  title: Text('User ID: ${participant.userId}'),
                  subtitle: Text('Status: ${participant.status}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}