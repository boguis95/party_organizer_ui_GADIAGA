// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      partyId: (json['partyId'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'partyId': instance.partyId,
      'status': instance.status,
    };
