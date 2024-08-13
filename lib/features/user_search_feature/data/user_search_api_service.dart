// ignore_for_file: prefer_collection_literals

import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/user_search_feature/data/search_user_model.dart';
import 'package:http/http.dart' as http;

import 'package:sentry_flutter/sentry_flutter.dart';

class UserSearchApiService {
  final http.Client _httpClient;

  UserSearchApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<SearchUserModel>> getUsersSearchData({
    required int receiveCountryId,
    required int serviceId,
    required String searchQuery,
  }) async {
    final responseBody = await _getData(
        receiveCountryId: receiveCountryId,
        serviceId: serviceId,
        searchQuery: searchQuery);
    try {
      List<SearchUserModel> areas = (responseBody['data'] as List)
          .map((e) => SearchUserModel.fromJson(e))
          .toList();

      return areas;
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'UserSearchApiService',
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
    required int receiveCountryId,
    required int serviceId,
    required String searchQuery,
  }) async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    final getUserSearchApiUrl = getRecipientDataApi(
        receiveCountryId: receiveCountryId,
        serviceId: serviceId,
        searchQuery: searchQuery);

    try {
      final response = await _httpClient.get(
        Uri.parse(getUserSearchApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      //
      return apiResponseHelper(
        response: response,
        className: 'UserSearchApiService',
        apiUrl: getUserSearchApiUrl,
        requestValue:
            'Get Request with receiveCountryId:$receiveCountryId, serviceId:$serviceId  and searchQuery:$searchQuery',
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
