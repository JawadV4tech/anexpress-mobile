// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/two_fa_security_screen/data/two_fa_api_service.dart';
import 'package:anexpress/features/two_fa_security_screen/data/two_fa_info_model.dart';

class PrivacyRepositoryException implements Exception {}

class TwoFARepository {
  TwoFARepository({TwoFaApiService? service})
      : _service = service ?? TwoFaApiService();
  final TwoFaApiService _service;

  Future<TwoFAInfoModel> requestGet2FAData() async {
    try {
      return _service.get2FAData();
    } on Exception {
      throw PrivacyRepositoryException();
    }
  }
}
