import 'dart:convert';
import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/store_calculation_feature/data/store_calculation_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class StoreCalculationApiService {
  final http.Client _httpClient;

  StoreCalculationApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<StoreCalculationModel> getStoreCalculationData({
    required Map<String, dynamic> requestMap,
  }) async {
    final responseBody = await _postData(requestMap: requestMap);

    try {
      //
      return StoreCalculationModel.fromJson(responseBody['data']);
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
  }) async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    "$requestMap".log();

    try {
      final response = await _httpClient.post(
        Uri.parse(postStoreCalculationsApi),
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
        apiUrl: postStoreCalculationsApi,
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
