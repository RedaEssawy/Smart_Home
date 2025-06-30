import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/models/update_consumption_rate_model.dart';

class UpdateConsumptionRateRepo {
  final ApiConsumer api;
  UpdateConsumptionRateRepo(this.api);
  Future<Either<String, UpdateConsumptionRateModel>> updateConsumptionRate(
      {required String tankLevel, required String period}) async {
    try {
      final response = await api.put(EndPoints.setTankLevelEndPoint,
          data: {ApiKey.threshold: tankLevel, ApiKey.period: period},
          options: BaseOptions(headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Token ${CacheHelper().getData(key: ApiKey.token)}',
          }));
      return Right(UpdateConsumptionRateModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UpdateConsumptionRateModel>> setConsumptionRate(
      {required String tankLevel, required String period}) async {
    try {
      final response = await api.post(EndPoints.setTankLevelEndPoint,
          data: {
            ApiKey.threshold: tankLevel,
            ApiKey.period: period,
            ApiKey.user: CacheHelper().getData(key: ApiKey.id).toString()
          },
          options: BaseOptions(headers: {
            // 'Content-Type': 'application/json',

            'Authorization':
                'Token ${CacheHelper().getData(key: ApiKey.token)}',
          }));
      return Right(UpdateConsumptionRateModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
