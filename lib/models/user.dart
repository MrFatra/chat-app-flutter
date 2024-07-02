import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String id;
  String fullName;
  String username;
  String gender;
  String avatar;

  User ({
    required this.id,
    required this.fullName,
    required this.username,
    required this.gender,
    required this.avatar,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
