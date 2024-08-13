// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/calculation_feature/data/calculation_api_service.dart';
import 'package:anexpress/features/calculation_feature/data/calculation_response_model.dart';

class CalculationRepositoryException implements Exception {}

class CalculationRepository {
  CalculationRepository({CalculationApiService? service})
      : _service = service ?? CalculationApiService();
  final CalculationApiService _service;

  Future<CalculationInfoModel> requestGetCalculationEvent({
    required Map<String, dynamic> requestValueMap,
  }) async {
    try {
      return _service.postRequestGetCalculationEvent(
        requestValueMap: requestValueMap,
      );
    } on Exception {
      throw CalculationRepositoryException();
    }
  }
}
