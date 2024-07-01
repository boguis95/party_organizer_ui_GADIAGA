import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modeles/Party.dart';
import '../providers/AuthProvider.dart';
import '../services/PartyService.dart';
import 'edit_party_screen.dart';


class ManagePartiesScreen extends StatefulWidget {
  @override
  _ManagePartiesScreenState createState() => _ManagePartiesScreenState();
}

class _ManagePartiesScreenState extends State<ManagePartiesScreen> {
  List<Party> _parties = [];

  @override
  void initState() {
    super.initState();
    _loadParties();
  }

  Future<void> _loadParties() async {
    try {
      List<Party> parties = await PartyService.getParties();
      setState(() {
        _parties = parties.where((party) => party.organizerId == Provider.of<AuthProvider>(context, listen: false).user!.id).toList();
      });
    } catch (e) {
      print('Failed to load parties: $e');
    }
  }

  void _deleteParty(int id) async {
    try {
      await PartyService.deleteParty(id);
      _loadParties();
    } catch (e) {
      print('Failed to delete party: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Parties'),
      ),
      body: ListView.builder(
        itemCount: _parties.length,
        itemBuilder: (context, index) {
          final party = _parties[index];
          return Card(
            child: ListTile(
              title: Text(party.name),
              subtitle: Text(party.location),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditPartyScreen(party: party)),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteParty(party.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}