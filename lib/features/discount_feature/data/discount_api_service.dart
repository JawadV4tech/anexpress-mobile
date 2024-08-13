import 'dart:convert';
import 'dart:io';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class DiscountApiService {
  final http.Client _httpClient;

  DiscountApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<double> getDiscountData({
    required Map<String, dynamic> requestMap,
    required String apiUrl,
  }) async {
    final responseBody = await _postData(
      requestMap: requestMap,
      apiUrl: apiUrl,
    );

    try {
      //
      if (responseBody['discount'].runtimeType == double) {
        return responseBody['discount'];
      } else {
        return double.parse(responseBody['discount']);
      }

      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'StoreCalculationApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //

      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw JsonDeserializationException(['$exception']);
    }
  }

  /// get Data Functions
  Future<dynamic> _postData({
    required Map<String, dynamic> requestMap,
    required String apiUrl,
  }) async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    "$requestMap".log();

    try {
      final response = await _httpClient.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(requestMap),
      );
      //
      return apiResponseHelper(
        response: response,
        className: 'StoreCalculationApiService',
        apiUrl: apiUrl,
        requestValue: StringValues.getRequest,
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
