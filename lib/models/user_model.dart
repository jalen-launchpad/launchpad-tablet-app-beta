import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String firstName;
  final String lastName;
  final String username;
  final String avatarUrl;

  bool operator ==(o) => o.username == username;
  int get hashCode => username.hashCode ^ firstName.hashCode;
  
  @override
  String toString() {
    return username;
  }

  UserModel({@required this.username, this.firstName, this.lastName, this.avatarUrl});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
