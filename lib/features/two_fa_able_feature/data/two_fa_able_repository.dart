// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/two_fa_able_feature/data/two_fa_able_api_service.dart';

class PrivacyRepositoryException implements Exception {}

class TwoFAableRepository {
  TwoFAableRepository({TwoFaAbleApiService? service})
      : _service = service ?? TwoFaAbleApiService();
  final TwoFaAbleApiService _service;

  Future<String> requestGet2FAData({
    required Map<String, dynamic> requestValueMap,
    required String apiEndpoint,
  }) async {
    try {
      return _service.post2FaAbleData(
        requestValueMap: requestValueMap,
        apiEndpoint: apiEndpoint,
      );
    } on Exception {
      throw PrivacyRepositoryException();
    }
  }
}
