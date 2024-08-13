import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/privacy_policy_screen/data/privacy_terms_conditions_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class PrivacyApiService {
  final http.Client _httpClient;

  PrivacyApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<PrivacyTermsModel> getCountriesData() async {
    final responseBody = await _getData();

    try {
      //
      return PrivacyTermsModel.fromJson(responseBody);

      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'PrivacyApiService',
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
    try {
      final response = await _httpClient.get(
        Uri.parse(getPrivacyApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      //
      return apiResponseHelper(
        response: response,
        className: 'PrivacyApiService',
        apiUrl: getCountriesApi,
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
