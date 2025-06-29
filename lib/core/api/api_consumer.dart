import 'package:dio/dio.dart';

abstract class ApiConsumer {
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
