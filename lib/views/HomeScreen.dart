import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modeles/Party.dart';
import '../providers/AuthProvider.dart';
import '../services/PartyService.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';
  String partyType = '';
  int? maxPeople;
  bool isPaid = false;
  String time = '';

  List<Party> _allParties = [];
  List<Party> _filteredParties = [];

  @override
  void initState() {
    super.initState();
    _loadParties();
  }

  Future<void> _loadParties() async {
    try {
      List<Party> parties = await PartyService.getParties();
      setState(() {
        _allParties = parties;
        _filteredParties = parties;
      });
    } catch (e) {
      // Handle error
      print('Failed to load parties: $e');
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredParties = _allParties.where((party) {
        bool matchesCity = city.isEmpty || party.location.toLowerCase().contains(city.toLowerCase());
        bool matchesPartyType = partyType.isEmpty || party.type.toLowerCase().contains(partyType.toLowerCase());
        bool matchesMaxPeople = maxPeople == null || party.maxParticipants >= maxPeople!;
        bool matchesIsPaid = !isPaid || party.paid;
        bool matchesTime = time.isEmpty || party.time.contains(time);

        return matchesCity && matchesPartyType && matchesMaxPeople && matchesIsPaid && matchesTime;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.username ?? 'Guest'}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create-party');
            },
            child: Text('Organiser mes bails', style: TextStyle(color: Colors.white),),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Find a Party', style: Theme.of(context).textTheme.headline1),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'City', filled: true, fillColor: Colors.white),
                onChanged: (value) => setState(() {
                  city = value;
                  _applyFilters();
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Party Type', filled: true, fillColor: Colors.white),
                onChanged: (value) => setState(() {
                  partyType = value;
                  _applyFilters();
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Max People', filled: true, fillColor: Colors.white),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  maxPeople = value.isNotEmpty ? int.tryParse(value) : null;
                  _applyFilters();
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(
                    value: isPaid,
                    onChanged: (value) {
                      setState(() {
                        isPaid = value!;
                        _applyFilters();
                      });
                    },
                  ),
                  Text('Is Paid'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Time', filled: true, fillColor: Colors.white),
                onChanged: (value) => setState(() {
                  time = value;
                  _applyFilters();
                }),
              ),
            ),
            _filteredParties.isEmpty
                ? Center(child: Text('No parties found', style: Theme.of(context).textTheme.bodyText2))
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _filteredParties.length,
              itemBuilder: (context, index) {
                final party = _filteredParties[index];
                return Card(
                  color: Colors.purple[100],
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(party.name, style: Theme.of(context).textTheme.headline6),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${party.location} - ${party.type}', style: Theme.of(context).textTheme.bodyText2),
                        Text('Date: ${party.date}', style: Theme.of(context).textTheme.bodyText2),
                        Text('Time: ${party.time}', style: Theme.of(context).textTheme.bodyText2),
                        Text('Slots: ${party.remainingSlots}/${party.maxParticipants}', style: Theme.of(context).textTheme.bodyText2),
                        Text(party.paid ? 'Paid' : 'Free', style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/party-details', arguments: party);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}