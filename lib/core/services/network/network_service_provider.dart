import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final Dio dio = Dio();
  final BaseOptions options = BaseOptions(
    connectTimeout: Duration(seconds: 60),
    receiveTimeout: Duration(seconds: 60),
    sendTimeout: Duration(seconds: 60)
  );

  dio.options = options;

  return dio;
});