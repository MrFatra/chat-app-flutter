// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      gender: json['gender'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'gender': instance.gender,
      'avatar': instance.avatar,
    };
