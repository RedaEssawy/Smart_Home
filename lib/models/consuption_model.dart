
import 'package:smart_home/core/api/end_points.dart';

class ConsumptionModel {
  final String monthlyConsumption;
  final String dailyConsumption;
  final String weeklyConsumption;
  final String last12hoursConsumption;

  ConsumptionModel({required this.monthlyConsumption,
   required this.dailyConsumption, required this.weeklyConsumption, required this.last12hoursConsumption
   });
  factory ConsumptionModel.fromJson(Map<String, dynamic> json) {
    return ConsumptionModel(
      monthlyConsumption: json[ApiKey.monthlyConsumption],
      dailyConsumption: json[ApiKey.dailyConsumption],
      weeklyConsumption: json[ApiKey.weeklyConsumption],
      last12hoursConsumption: json[ApiKey.last12hoursConsumption],
    );
  }
}