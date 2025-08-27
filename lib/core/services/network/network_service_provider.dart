import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final Dio dio = Dio();
  final BaseOptions options = BaseOptions(
    baseUrl: "https://dev.lurn.lk/backend/api/v1",  // TODO: move base url to env
    connectTimeout: Duration(seconds: 60),
    receiveTimeout: Duration(seconds: 60),
    sendTimeout: Duration(seconds: 60)
  );

  dio.options = options;

  dio.interceptors.addAll([
    HttpFormatter(),
  ]);

  return dio;
});