import 'package:smart_home/core/api/end_points.dart';

class UserModel {
  // final String profilePic;
  final String name;
  final String email;
  final String phone;
  final Map<String, dynamic> address;

  UserModel(
      {
        // required this.profilePic,
      required this.name,
      required this.email,
      required this.phone,
      required this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // profilePic: json['user'][ApiKey.profilePic],
      name: json['user'][ApiKey.name],
      email: json['user'][ApiKey.email],
      phone: json['user'][ApiKey.phone],
      address: json['user'][ApiKey.location],
    );
  }
}
