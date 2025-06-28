
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/models/consuption_model.dart';

class ConsumptionRepository {
  final ApiConsumer api;

  ConsumptionRepository({required this.api});
    Future<Either< String,List<ConsumptionModel>>>
    getConsumptionRate()async{
      try {
       final response = await api.get(EndPoints.getConsumptionRateEndPoint,options: BaseOptions(

        
        
        headers: {
          // 'Content-Type': 'application/json',
          // 'Accept': 'application/json',

          'Authorization': 'Token ${CacheHelper().getData(key: ApiKey.token)}'} ));



       final list = List<ConsumptionModel>.from(response.map((x) => ConsumptionModel.fromJson(x)));   
       return Right(list);
         }    on ServerException catch (e) {
       return Left(e.errorModel.errorMessage);

      }
  }
}

