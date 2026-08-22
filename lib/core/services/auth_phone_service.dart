import 'dart:developer';

import 'package:dio/dio.dart';

import 'api_service.dart';

class AuthPhoneService {
  final ApiService apiService;

  AuthPhoneService({required this.apiService});

  Future<Map<String, dynamic>> sendOtp({required String phone}) async {
    try {
      var data = await apiService.post(
        endPoint: 'send',
        data: {'phone': phone},
      );
      log("auth data :$data");
      return data;
    } on DioException catch (e) {
      log('STATUS CODE: ${e.response?.statusCode}');
      log('RESPONSE DATA: ${e.response?.data}');
      log('RESPONSE HEADERS: ${e.response?.headers}');
      log('REQUEST URL: ${e.requestOptions.uri}');
      log('REQUEST HEADERS: ${e.requestOptions.headers}');

      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
