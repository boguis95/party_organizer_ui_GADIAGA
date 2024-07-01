import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modeles/Party.dart';
import '../services/PartyService.dart';


class CreatePartyScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _remainingSlotsController = TextEditingController();
  final TextEditingController _maxParticipantsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Party'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextField(
              controller: _remainingSlotsController,
              decoration: InputDecoration(labelText: 'Remaining Slots'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxParticipantsController,
              decoration: InputDecoration(labelText: 'Max Participants'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                final party = Party(
                  id: 0,
                  name: _nameController.text,
                  location: _locationController.text,
                  description: _descriptionController.text,
                  type: 'CLASSIC', // ou 'THEME'
                  date: _dateController.text,
                  time: _timeController.text,
                  remainingSlots: int.parse(_remainingSlotsController.text),
                  maxParticipants: int.parse(_maxParticipantsController.text),
                  paid: _priceController.text.isNotEmpty,
                  price: double.parse(_priceController.text),
                  organizerId: 1, // Utilisez l'ID de l'organisateur actuel
                );
                await PartyService.createParty(party);
                Navigator.pushNamed(context, "/manage-parties");
              },
              child: Text('Create Party'),
            ),
          ],
        ),
      ),
    );
  }
}