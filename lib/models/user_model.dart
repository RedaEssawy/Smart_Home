class UserModel {
    UserModel({
        required this.id,
        required this.username,
        required this.fullName,
        required this.role,
        required this.homeAddress,
        required this.phoneNumber,
        required this.email,
        required this.createdAt,
    });

    final int? id;
    final String? username;
    final String? fullName;
    final String? role;
    final String? homeAddress;
    final String? phoneNumber;
    final String? email;
    final DateTime? createdAt;

    factory UserModel.fromJson(Map<String, dynamic> json){ 
        return UserModel(
            id: json["id"],
            username: json["username"],
            fullName: json["full_name"],
            role: json["role"],
            homeAddress: json["home_address"],
            phoneNumber: json["phone_number"],
            email: json["email"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
        );
    }

}












// import 'package:smart_home/core/api/end_points.dart';

// class UserModel {
//   // final String profilePic;
//   final String name;
//   final String email;
//   final String phone;
//   final Map<String, dynamic> address;

//   UserModel(
//       {
//         // required this.profilePic,
//       required this.name,
//       required this.email,
//       required this.phone,
//       required this.address});

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       // profilePic: json['user'][ApiKey.profilePic],
//       name: json['user'][ApiKey.name],
//       email: json['user'][ApiKey.email],
//       phone: json['user'][ApiKey.phone],
//       address: json['user'][ApiKey.location],
//     );
//   }
// }
