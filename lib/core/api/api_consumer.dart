import 'package:dio/dio.dart';

abstract class ApiConsumer {
/*************  ✨ Windsurf Command ⭐  *************/
  /// Makes a GET request to the specified [path].
  ///
  /// [data] will be converted to a JSON string and sent as the request body.
  ///
  /// [queryParameters] will be converted to query parameters.
  ///
///*******  5d0fa1c2-5455-44a4-9878-bf62b29a8dcd  *******/
  Future<dynamic> get(
    
    String path, {
      BaseOptions? options,
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post(
    String path, {
      BaseOptions? options,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> put(
    String path, {
      BaseOptions? options,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String path, {
      BaseOptions? options,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
