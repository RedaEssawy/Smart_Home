class ConsumptionModel {
    ConsumptionModel({
        required this.id,
        required this.consumption,
        required this.period,
        required this.timestamp,
        required this.sensorId,
        required this.user,
    });

    final int? id;
    final double? consumption;
    final String? period;
    final DateTime? timestamp;
    final String? sensorId;
    final int? user;

    factory ConsumptionModel.fromJson(Map<String, dynamic> json){ 
        return ConsumptionModel(
            id: json["id"],
            consumption: json["consumption"],
            period: json["period"],
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
            sensorId: json["sensor_id"],
            user: json["user"],
        );
    }

}






















// import 'package:smart_home/core/api/end_points.dart';

// class ConsumptionModel {
//   final String monthlyConsumption;
//   final String dailyConsumption;
//   final String weeklyConsumption;
//   final String last12hoursConsumption;

//   ConsumptionModel({required this.monthlyConsumption,
//    required this.dailyConsumption, required this.weeklyConsumption, required this.last12hoursConsumption
//    });
//   factory ConsumptionModel.fromJson(Map<String, dynamic> json) {
//     return ConsumptionModel(
//       monthlyConsumption: json[ApiKey.monthlyConsumption],
//       dailyConsumption: json[ApiKey.dailyConsumption],
//       weeklyConsumption: json[ApiKey.weeklyConsumption],
//       last12hoursConsumption: json[ApiKey.last12hoursConsumption],
//     );
//   }
// }