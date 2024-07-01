import 'package:flutter/material.dart';

import '../modeles/Party.dart';
import '../services/PartyService.dart';


class EditPartyScreen extends StatefulWidget {
  final Party party;

  EditPartyScreen({required this.party});

  @override
  _EditPartyScreenState createState() => _EditPartyScreenState();
}

class _EditPartyScreenState extends State<EditPartyScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _typeController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _remainingSlotsController;
  late TextEditingController _maxParticipantsController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  bool isPaid = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.party.name);
    _locationController = TextEditingController(text: widget.party.location);
    _typeController = TextEditingController(text: widget.party.type);
    _dateController = TextEditingController(text: widget.party.date);
    _timeController = TextEditingController(text: widget.party.time);
    _remainingSlotsController = TextEditingController(text: widget.party.remainingSlots.toString());
    _maxParticipantsController = TextEditingController(text: widget.party.maxParticipants.toString());
    _priceController = TextEditingController(text: widget.party.price.toString());
    _descriptionController = TextEditingController(text: widget.party.description);
    isPaid = widget.party.paid;
  }

  void _updateParty() async {
    if (_formKey.currentState!.validate()) {
      Party updatedParty = Party(
        id: widget.party.id,
        name: _nameController.text,
        location: _locationController.text,
        type: _typeController.text,
        date: _dateController.text,
        time: _timeController.text,
        remainingSlots: int.parse(_remainingSlotsController.text),
        maxParticipants: int.parse(_maxParticipantsController.text),
        paid: widget.party.paid ,
        price: isPaid ? double.parse(_priceController.text) : 0,
        organizerId: widget.party.organizerId, description: _descriptionController.text,
      );

      try {
        await PartyService.updateParty(widget.party.id, updatedParty);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Party updated successfully')));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update party')));

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update party')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Party'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Party Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the party name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the type of party';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _remainingSlotsController,
                decoration: InputDecoration(labelText: 'Remaining Slots'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the remaining slots';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _maxParticipantsController,
                decoration: InputDecoration(labelText: 'Max Participants'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the max participants';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Is Paid'),
                value: isPaid,
                onChanged: (value) {
                  setState(() {
                    isPaid = value;
                  });
                },
              ),
              if (isPaid)
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
              ElevatedButton(
                onPressed: _updateParty,
                child: Text('Update Party'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}