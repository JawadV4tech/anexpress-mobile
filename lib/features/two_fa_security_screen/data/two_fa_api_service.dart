import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/two_fa_security_screen/data/two_fa_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class TwoFaApiService {
  final http.Client _httpClient;

  TwoFaApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<TwoFAInfoModel> get2FAData() async {
    final responseBody = await _getData();

    try {
      //
      return TwoFAInfoModel.fromJson(responseBody);

      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'TwoFaApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //

      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw JsonDeserializationException(['$exception']);
    }
  }

  /// get Data Functions
  Future<dynamic> _getData() async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);
    try {
      final response = await _httpClient.get(
        Uri.parse(get2faApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      //
      return apiResponseHelper(
        response: response,
        className: 'TwoFaApiService',
        apiUrl: get2faApi,
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
