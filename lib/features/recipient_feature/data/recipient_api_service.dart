import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/recipient_feature/data/send_money_recipient_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class ReceipientApiService {
  final http.Client _httpClient;

  ReceipientApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<SendMoneyRecipientModel> getRecipientSendMoneyData({
    required int id,
  }) async {
    //
    final responseBody = await _getData(id: id);

    try {
      //
      return SendMoneyRecipientModel.fromJson(responseBody['data']);

      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'ReceipientApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //
      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw Exception(exception);
    }
  }

  /// get Data Functions
  Future<dynamic> _getData({
    required int id,
  }) async {
    //
    final sendMoneyRecipientApiUrl = getSendMoneyRecipientApiUrl(id: id);
    //
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);
    //
    try {
      final response = await _httpClient.get(
        Uri.parse(sendMoneyRecipientApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      //
      return apiResponseHelper(
        response: response,
        className: 'ReceipientApiService',
        apiUrl: sendMoneyRecipientApiUrl,
        requestValue: "get Request",
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
