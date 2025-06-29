class MotorModel {
    MotorModel({
        required this.status,
        required this.topic,
        required this.payload,
    });

    final String? status;
    final String? topic;
    final String payload;

    factory MotorModel.fromJson(Map<String, dynamic> json){ 
        return MotorModel(
            status: json["status"],
            topic: json["topic"],
            payload: json["payload"],
        );
    }

}
