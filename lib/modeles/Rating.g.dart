// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      partyId: (json['partyId'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'partyId': instance.partyId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
    };
