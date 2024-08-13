// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/privacy_policy_screen/data/privacy_api_service.dart';
import 'package:anexpress/features/privacy_policy_screen/data/privacy_terms_conditions_model.dart';

class PrivacyRepositoryException implements Exception {}

class PrivacyRepository {
  PrivacyRepository({PrivacyApiService? service})
      : _service = service ?? PrivacyApiService();
  final PrivacyApiService _service;

  Future<PrivacyTermsModel> requestGetPrivacyData() async {
    try {
      return _service.getCountriesData();
    } on Exception {
      throw PrivacyRepositoryException();
    }
  }
}
