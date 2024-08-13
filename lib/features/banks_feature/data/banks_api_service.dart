import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/banks_feature/data/bank_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class BanksApiService {
  final http.Client _httpClient;

  BanksApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<BankInfoModel>> getBanksData(
      {required int receiveCountryId}) async {
    final responseBody = await _getData(receiveCountryId: receiveCountryId);

    try {
      //
      return (responseBody['banksList'] as List)
          .map((i) => BankInfoModel.fromJson(i))
          .toList();
      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'BanksApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //

      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw JsonDeserializationException(['$exception']);
    }
  }

  /// get Data Functions
  Future<dynamic> _getData({required int receiveCountryId}) async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    final banksApiUrl = getBanksApi(receiveCountryId: receiveCountryId);

    try {
      final response = await _httpClient.get(
        Uri.parse(banksApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      //
      return apiResponseHelper(
        response: response,
        className: 'BanksApiService',
        apiUrl: banksApiUrl,
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
