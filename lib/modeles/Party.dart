import 'package:json_annotation/json_annotation.dart';

part 'Party.g.dart';

@JsonSerializable()
class Party {
  final int id;
  final String name;
  final String location;
  final String description;
  final String type;
  final String date;
  final String time;
  final int remainingSlots;
  final int maxParticipants;
  final bool paid;
  final double price;
  final int organizerId;

  Party({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.type,
    required this.date,
    required this.time,
    required this.remainingSlots,
    required this.maxParticipants,
    required this.paid,
    required this.price,
    required this.organizerId,
  });

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);
  Map<String, dynamic> toJson() => _$PartyToJson(this);
}