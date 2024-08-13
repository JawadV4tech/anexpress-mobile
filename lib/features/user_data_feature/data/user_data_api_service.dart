// ignore_for_file: prefer_collection_literals

import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/user_data_feature/data/search_user_data_model.dart';
import 'package:http/http.dart' as http;

import 'package:sentry_flutter/sentry_flutter.dart';

class UserDataApiService {
  final http.Client _httpClient;

  UserDataApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<SearchUserDataModel> getUsersDataById({
    required int userId,
  }) async {
    final responseBody = await _getData(userId: userId);
    try {
      return SearchUserDataModel.fromJson(responseBody['data']);
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'UserDataApiService',
        logType: LoggerType.e,
        message: '$exception\n$stackTrace',
      );

      //

      await Sentry.captureException(exception, stackTrace: stackTrace);
      throw JsonDeserializationException(['$exception']);
    }
  }

  /// get Data Functions
  Future<dynamic> _getData({
    required int userId,
  }) async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    final getUserDataApi = getUserDataApiUrl(userId: userId);

    try {
      final response = await _httpClient.get(
        Uri.parse(getUserDataApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      //
      return apiResponseHelper(
          response: response,
          className: 'UserDataApiService',
          apiUrl: getUserDataApi,
          requestValue: 'Get Request with userId:$userId');
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
