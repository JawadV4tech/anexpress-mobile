import 'dart:convert';

import 'package:anexpress/core/config/app_exceptions.dart';
import 'package:anexpress/core/config/logger.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

dynamic apiResponseHelper({
  required http.Response response,
  required String className,
  required String apiUrl,
  required String requestValue,
}) async {
  // print log the response
  printLog(
    classFileName: className,
    logType: LoggerType.w,
    message:
        'url:$apiUrl\nreq:$requestValue\nres:${response.statusCode}:${json.encode(response.body)}',
  );

  switch (response.statusCode) {
    case 200:
      try {
        return json.decode(response.body);
      } catch (exception, stackTrace) {
        await Sentry.captureException(exception, stackTrace: stackTrace);

        throw JsonDecodeException("Error Loading Data");
      }
    case 503:
      throw HttpException("Error Loading Data");
    case 302:
      throw HttpException("Session Expired Please login again");
    case 504:
      throw HttpException(
          "Request Time-out, unable to communicate, please try again");
    default:
      final decodedResponse = json.decode(response.body);
      await Sentry.captureMessage(response.body);

      // Check if the decoded response is HTML by looking for common HTML tags
      if (decodedResponse is String &&
          decodedResponse.contains(RegExp(r'<html>|<head>|<body>|<div>|<p>',
              caseSensitive: false))) {
        throw HttpException('Unable to communicate, please try again');
      }

      final error = decodedResponse['error'] ?? '';
      final errors = decodedResponse['errors'] ?? '';
      final message = decodedResponse['message'] ?? '';
      final details = decodedResponse['details'] ?? '';

      final errorMessage = [
        if (error.isNotEmpty) error,
        if (errors.isNotEmpty) errors,
        if (message.isNotEmpty) message,
        if (details.isNotEmpty) details,
      ].join(' ');

      throw HttpException(errorMessage);
  }
}
