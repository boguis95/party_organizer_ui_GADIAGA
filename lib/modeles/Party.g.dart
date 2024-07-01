// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Party _$PartyFromJson(Map<String, dynamic> json) => Party(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      remainingSlots: (json['remainingSlots'] as num).toInt(),
      maxParticipants: (json['maxParticipants'] as num).toInt(),
      paid: json['paid'] as bool,
      price: (json['price'] as num).toDouble(),
      organizerId: (json['organizerId'] as num).toInt(),
    );

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'description': instance.description,
      'type': instance.type,
      'date': instance.date,
      'time': instance.time,
      'remainingSlots': instance.remainingSlots,
      'maxParticipants': instance.maxParticipants,
      'paid': instance.paid,
      'price': instance.price,
      'organizerId': instance.organizerId,
    };
