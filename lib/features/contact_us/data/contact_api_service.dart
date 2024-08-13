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

class ContactApiService {
  final http.Client _httpClient;

  ContactApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<String> sendContactEmail({
    required Map<String, dynamic> requestValueMap,
  }) async {
    final responseBody = await _postData(requestValueMap: requestValueMap);
    try {
      //
      return responseBody["message"];
      //
    } catch (exception, stackTrace) {
      ///
      ///==========
      printLog(
        classFileName: 'ContactApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      ///==========

      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw JsonDeserializationException(['$exception']);
    }
  }

  /// post Data Functions
  Future<dynamic> _postData({
    required Map<String, dynamic> requestValueMap,
  }) async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    try {
      final response = await _httpClient.post(Uri.parse(postContactApi),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(requestValueMap));
      //
      return apiResponseHelper(
        response: response,
        className: 'ContactApiService',
        apiUrl: postContactApi,
        requestValue: 'requestValue: $requestValueMap',
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
