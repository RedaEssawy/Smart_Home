import 'package:dio/dio.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/end_points.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        CacheHelper().getData(key: ApiKey.token) != null
            ? 'Token ${CacheHelper().getData(key: ApiKey.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
