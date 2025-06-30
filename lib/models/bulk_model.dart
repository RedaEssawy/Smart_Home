class BulkModel {
    BulkModel({
        required this.message,
        required this.results,
    });

    final String? message;
    final List<Result> results;

    factory BulkModel.fromJson(Map<String, dynamic> json){ 
        return BulkModel(
            message: json["message"],
            results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
        );
    }

}

class Result {
    Result({
        required this.topic,
        required this.status,
        required this.payload,
    });

    final String? topic;
    final String? status;
    final String? payload;

    factory Result.fromJson(Map<String, dynamic> json){ 
        return Result(
            topic: json["topic"],
            status: json["status"],
            payload: json["payload"],
        );
    }

}
