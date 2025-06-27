class SignInModel {
    SignInModel({
        required this.token,
        required this.user,
    });

    final String? token;
    final User? user;

    factory SignInModel.fromJson(Map<String, dynamic> json){ 
        return SignInModel(
            token: json["token"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

}

class User {
    User({
        required this.id,
        required this.username,
        required this.phoneNumber,
        required this.email,
        required this.fullName,
        required this.homeAddress,
        required this.role,
    });

    final int? id;
    final String? username;
    final String? phoneNumber;
    final String? email;
    final String? fullName;
    final String? homeAddress;
    final String? role;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            username: json["username"],
            phoneNumber: json["phone_number"],
            email: json["email"],
            fullName: json["full_name"],
            homeAddress: json["home_address"],
            role: json["role"],
        );
    }

}
