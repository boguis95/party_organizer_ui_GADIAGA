import 'package:json_annotation/json_annotation.dart';

part 'Rating.g.dart';

@JsonSerializable()
class Rating {
  final int id;
  final int userId;
  final int partyId;
  final int rating;
  final String comment;
  final String createdAt;

  Rating({
    required this.id,
    required this.userId,
    required this.partyId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}