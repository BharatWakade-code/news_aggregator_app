import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_aggregator_app/utils/contstants.dart';

class ApiService {
  final Dio _dio = Dio();
  ApiService() {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(minutes: 4);
  }

  Future<Response> getApi(String url, Map<String, dynamic>? request) async {
    try {
      final response = await _dio.get(
        '${Constanst.baseurl}/$url',
        queryParameters: request,
      );
      final fullUrl = Uri.https(
        response.requestOptions.uri.host,
        response.requestOptions.uri.path,
        response.requestOptions.queryParameters,
      );
      log('Full URL: $fullUrl');

      if (response.statusCode == 200) {
        log('response: $response');
        return response;
      } else {
        throw DioException.badResponse(
          statusCode: response.statusCode ?? 0,
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception("An unexpected error occurred");
    }
  }


}
