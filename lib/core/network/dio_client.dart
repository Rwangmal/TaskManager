import 'package:dio/dio.dart';

import 'api_constants.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'apikey': ApiConstants.apiKey,
          'Authorization': 'Bearer ${ApiConstants.apiKey}',
          'Content-Type': 'application/json',
          'Prefer': 'return=representation',
        },
      ),
    );
  }
}