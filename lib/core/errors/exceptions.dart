import 'package:dio/dio.dart';
import 'package:smart_home/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}










 void handleDioExceptions(DioException e) {
        switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.sendTimeout:
        throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.receiveTimeout:
        throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badCertificate:
        throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data));
    
      case DioExceptionType.cancel:
        throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.connectionError:
        throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.unknown:
        throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badResponse:
       switch (e.response?.statusCode) {
        // 400: message means bad request 
         case 400:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
               
         case 401:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
               case 403:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
           
         case 404:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
               case 409:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
           
           case 422:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
           
           case 500:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
           
         default:
           throw ServerException(
               errorModel: ErrorModel.fromJson(e.response!.data));
         
       }
    }
  }