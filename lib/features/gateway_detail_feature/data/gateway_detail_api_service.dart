import 'dart:convert';
import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/helpers/api_response_helper.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/features/gateway_detail_feature/data/gateway_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class GateWayDetailApiService {
  final http.Client _httpClient;

  GateWayDetailApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<GatewayDetailModel> getGatewayDetailData({
    required Map<String, dynamic> requestMap,
  }) async {
    final responseBody = await _getData(requestMap: requestMap);

    try {
      //
      return GatewayDetailModel.fromJson(responseBody['data']);
      //
    } catch (exception, stackTrace) {
      //
      printLog(
        classFileName: 'postGatewayDetailApi',
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
    required Map<String, dynamic> requestMap,
  }) async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);
    try {
      final response = await _httpClient.post(
        Uri.parse(postGatewayDetailApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(requestMap),
      );
      //
      return apiResponseHelper(
        response: response,
        className: 'GateWayDetailApiService',
        apiUrl: postGatewayDetailApi,
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
