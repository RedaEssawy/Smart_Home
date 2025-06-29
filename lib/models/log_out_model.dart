class LogOutModel {
    LogOutModel({
        required this.message,
    });

    final String? message;

    factory LogOutModel.fromJson(Map<String, dynamic> json){ 
        return LogOutModel(
            message: json["message"],
        );
    }

}
