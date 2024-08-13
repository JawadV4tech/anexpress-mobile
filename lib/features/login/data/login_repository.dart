// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/login/data/login_api_service.dart';
import 'package:anexpress/features/login/data/login_response_model.dart';

class LoginRepositoryException implements Exception {}

class LoginRepository {
  LoginRepository({LoginApiService? service})
      : _service = service ?? LoginApiService();
  final LoginApiService _service;

  Future<LoginResponseModel> requestUserLogin({
    required Map<String, dynamic> requestValueMap,
    required String loginApiEndpoint,
  }) async {
    try {
      return _service.postUserLoginData(
        requestValueMap: requestValueMap,
        loginApiEndpoint: loginApiEndpoint,
      );
    } on Exception {
      throw LoginRepositoryException();
    }
  }
}
