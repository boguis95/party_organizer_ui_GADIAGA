import 'package:json_annotation/json_annotation.dart';

part 'Message.g.dart';

@JsonSerializable()
class Message {
  final int id;
  final int senderId;
  final int recipientId;
  final int partyId;
  final String content;
  final String createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.partyId,
    required this.content,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}