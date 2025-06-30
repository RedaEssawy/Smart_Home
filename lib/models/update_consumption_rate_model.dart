class UpdateConsumptionRateModel {
    UpdateConsumptionRateModel({
        required this.id,
        required this.threshold,
        required this.period,
        required this.user,
    });

    final int? id;
    final double threshold;
    final String period;
    final int? user;

    factory UpdateConsumptionRateModel.fromJson(Map<String, dynamic> json){ 
        return UpdateConsumptionRateModel(
            id: json["id"],
            threshold: json["threshold"],
            period: json["period"],
            user: json["user"],
        );
    }

}
