import 'dart:io';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/login/data/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginApiService {
  final http.Client _httpClient;

  LoginApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<LoginResponseModel> postUserLoginData({
    required Map<String, dynamic> requestValueMap,
    required String loginApiEndpoint,
  }) async {
    final responseBody = await _postData(
      requestValueMap: requestValueMap,
      loginApiEndpoint: loginApiEndpoint,
    );

    try {
      //
      if (responseBody['access_token'] == null) {
        //Code sent on your email
        throw Exception(responseBody['message']);
      } else {
        return LoginResponseModel.fromJson(responseBody);
      }

      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'LoginApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //

      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw Exception('$exception');
    }
  }

  /// get Data Functions
  Future<dynamic> _postData({
    required Map<String, dynamic> requestValueMap,
    required String loginApiEndpoint,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse(loginApiEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: requestValueMap,
      );

      //
      return apiResponseHelper(
        response: response,
        className: 'LoginApiService',
        apiUrl: loginApiEndpoint,
        requestValue: '$requestValueMap',
      );
      //
    } on SocketException {
      throw HttpException(StringValues.no_internet);
      //
    } catch (exception, stackTrace) {
      //
      await Sentry.captureException(exception, stackTrace: stackTrace);

      throw HttpException('Error Communicating with Server');
      //
    }
  }
}
