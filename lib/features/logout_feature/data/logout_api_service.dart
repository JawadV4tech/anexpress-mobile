import 'dart:convert';
import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class LogoutApiService {
  final http.Client _httpClient;

  LogoutApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<String> performUserLogout() async {
    final responseBody = await _postData();

    try {
      //
      return responseBody['message'];
      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'LogoutApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //
      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw JsonDeserializationException(['$exception']);
    }
  }

  /// get Data Functions
  Future<dynamic> _postData() async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);
    try {
      final response = await _httpClient.post(
        Uri.parse(userLogoutApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({}),
      );

      //
      return apiResponseHelper(
        response: response,
        className: 'LogoutApiService',
        apiUrl: userLogoutApi,
        requestValue: '{}',
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
