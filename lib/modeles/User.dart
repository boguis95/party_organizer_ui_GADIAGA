import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  final String email;
  final String name;
  final int age;
  final String city;
  final double rating;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.age,
    required this.city,
    required this.rating,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}