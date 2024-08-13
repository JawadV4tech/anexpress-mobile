// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/register/data/register_api_service.dart';

class RegisterRepositoryException implements Exception {}

class RegisterRepository {
  RegisterRepository({RegisterApiService? service})
      : _service = service ?? RegisterApiService();
  final RegisterApiService _service;

  Future<String> requestUserRegister({
    required Map<String, dynamic> requestValueMap,
  }) async {
    try {
      return _service.postUserRegisterData(
        requestValueMap: requestValueMap,
      );
    } on Exception {
      throw RegisterRepositoryException();
    }
  }
}
