import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/models/bulk_model.dart';

class BulkRepo {
  final ApiConsumer api;
  BulkRepo(this.api);
Future<Either<String, BulkModel>> setMotor({required String value})async{
  try {
    final response = await api.post(EndPoints.bulkEndPoint,
        data: {ApiKey.value: value,ApiKey.topic:"home/tankRoom/motor"},
        options: BaseOptions(headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Token ${CacheHelper().getData(key: ApiKey.token)}',
        }));
    return Right(BulkModel.fromJson(response));
  } on ServerException catch (e) {
    return Left(e.errorModel.errorMessage);
  }
  
}  

Future<Either<String, BulkModel>> setAutomode({required String value})async{
  try {
    final response = await api.post(EndPoints.bulkEndPoint,
        data: {ApiKey.value: value,ApiKey.topic:"home/tankRoom/automode"},
        options: BaseOptions(headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Token ${CacheHelper().getData(key: ApiKey.token)}',
        }));
    return Right(BulkModel.fromJson(response));
  } on ServerException catch (e) {
    return Left(e.errorModel.errorMessage);
  }
  
}  

Future<Either<String, BulkModel>> setCadoValve({required String value})async{
  try {
    final response = await api.post(EndPoints.bulkEndPoint,
        data: {ApiKey.value: value,ApiKey.topic:"home/tankRoom/cadoValve"},
        options: BaseOptions(headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Token ${CacheHelper().getData(key: ApiKey.token)}',
        }));
    return Right(BulkModel.fromJson(response));
  } on ServerException catch (e) {
    return Left(e.errorModel.errorMessage);
  }
  
}  

Future<Either<String, BulkModel>> setMainValve({required String value})async{
  try {
    final response = await api.post(EndPoints.bulkEndPoint,
        data: {ApiKey.value: value,ApiKey.topic:"home/tankRoom/mainValve"},
        options: BaseOptions(headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Token ${CacheHelper().getData(key: ApiKey.token)}',
        }));
    return Right(BulkModel.fromJson(response));
  } on ServerException catch (e) {
    return Left(e.errorModel.errorMessage);
  }
  
}  

Future<Either<String, BulkModel>> setTankValve({required String value})async{
  try {
    final response = await api.post(EndPoints.bulkEndPoint,
        data: {ApiKey.value: value,ApiKey.topic:"home/tankRoom/tankValve"},
        options: BaseOptions(headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Token ${CacheHelper().getData(key: ApiKey.token)}',
        }));
    return Right(BulkModel.fromJson(response));
  } on ServerException catch (e) {
    return Left(e.errorModel.errorMessage);
  }
  
}  


}
