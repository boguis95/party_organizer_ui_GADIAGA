import 'package:json_annotation/json_annotation.dart';

part 'Participant.g.dart';

@JsonSerializable()
class Participant {
  final int id;
  final int userId;
  final int partyId;
  final String status;

  Participant({
    required this.id,
    required this.userId,
    required this.partyId,
    required this.status,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => _$ParticipantFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}