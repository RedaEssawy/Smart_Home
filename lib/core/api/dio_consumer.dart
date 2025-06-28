import 'package:dio/dio.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/api_interceptors.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  bool needToken  ;

  DioConsumer({required this.dio, this.needToken=true}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
      
    ));
    if(needToken == true)
    {
    dio.options.headers = {
      'Authorization': 'Token ${CacheHelper().getData(key: ApiKey.token)}',
    };
  }}
  @override
  Future delete(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      BaseOptions? options
      
        
      
      }) async {
    try {
      final response = await dio.delete(path,
          data: isFormData
              ? FormData.fromMap(data as Map<String, dynamic>)
              : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters ,BaseOptions? options}) async {
    try {
      final response =
          await dio.get(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      BaseOptions? options
      
      }) async {
    try {
      final response = await dio.post(path,
          data: isFormData
              ? FormData.fromMap(data as Map<String, dynamic>)
              : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future put(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      BaseOptions? options}) async {
    try {
      final response = await dio.put(path,
          data: isFormData
              ? FormData.fromMap(data as Map<String, dynamic>)
              : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
