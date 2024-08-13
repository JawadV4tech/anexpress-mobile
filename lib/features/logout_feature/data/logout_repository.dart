// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/logout_feature/data/logout_api_service.dart';

class LogoutRepositoryException implements Exception {}

class LogoutRepository {
  LogoutRepository({LogoutApiService? service})
      : _service = service ?? LogoutApiService();
  final LogoutApiService _service;

  Future<String> requestUserLogout() async {
    try {
      return _service.performUserLogout();
    } on Exception {
      throw LogoutRepositoryException();
    }
  }
}
