// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: (json['id'] as num).toInt(),
      senderId: (json['senderId'] as num).toInt(),
      recipientId: (json['recipientId'] as num).toInt(),
      partyId: (json['partyId'] as num).toInt(),
      content: json['content'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'recipientId': instance.recipientId,
      'partyId': instance.partyId,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
