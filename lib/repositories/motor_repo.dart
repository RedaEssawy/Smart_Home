import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/models/motor_model.dart';

class MotorRepo {
  final ApiConsumer api;

  MotorRepo({required this.api});

  Future<Either<String, MotorModel>> getMotorStatus(
      {required bool motorStatus}) async {
    try {
      final response = await api.post(EndPoints.getMotorStatusEndPoint,
          data: {
            ApiKey.payload: motorStatus,
            ApiKey.topic: "home/tankRoom/motor"
          },
          options: BaseOptions(headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Token ${CacheHelper().getData(key: ApiKey.token)}',
          }));
      return Right(MotorModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
