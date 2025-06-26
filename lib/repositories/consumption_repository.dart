import 'package:dartz/dartz.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/models/consuption_model.dart';

class ConsumptionRepository {
  final ApiConsumer api;

  ConsumptionRepository({required this.api});
    Future<Either<String,ConsumptionModel>>
    getConsumptionRate()async{
      try {
       final response = await api.get(EndPoints.getConsumptionRateEndPoint);
       return Right(ConsumptionModel.fromJson(response));
         }    on ServerException catch (e) {
       return Left(e.errorModel.errorMessage);

      }
  }
}