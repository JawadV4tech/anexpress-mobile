import 'dart:convert';
import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class RegisterApiService {
  final http.Client _httpClient;

  RegisterApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<String> postUserRegisterData({
    required Map<String, dynamic> requestValueMap,
  }) async {
    
    final responseBody = await _postData(
      requestValueMap: requestValueMap,
    );

    try {
      //
      if (responseBody['data'] != null) {
        return responseBody['access_token'];
      } else {
        String errorMessage = "Error Creating Account\n";

        if (responseBody['username'] != null) {
          errorMessage += '${responseBody['username'][0]}';
        }

        if (responseBody['email'] != null) {
          errorMessage += '${responseBody['email'][0]}';
        }

        throw Exception(errorMessage);
      }

      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'RegisterApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //
      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw Exception(exception);
    }
  }

  /// get Data Functions
  Future<dynamic> _postData({
    required Map<String, dynamic> requestValueMap,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse(userRegisterApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(requestValueMap),
      );
      //
      return apiResponseHelper(
        response: response,
        className: 'RegisterApiService',
        apiUrl: userRegisterApi,
        requestValue: '$requestValueMap',
      );
      //
    } on SocketException {
      //
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
