class TankAndFlowModel {
    TankAndFlowModel({
        required this.id,
        required this.value,
        required this.metricType,
        required this.timestamp,
        required this.sensorId,
        required this.user,
    });

    final int? id;
    final double value;
    final String? metricType;
    final DateTime? timestamp;
    final String? sensorId;
    final int? user;

    factory TankAndFlowModel.fromJson(Map<String, dynamic> json){ 
        return TankAndFlowModel(
            id: json["id"],
            value: json["value"],
            metricType: json["metric_type"],
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
            sensorId: json["sensor_id"],
            user: json["user"],
        );
    }

}
