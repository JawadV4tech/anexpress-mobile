// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/store_calculation_feature/data/store_calculation_api_service.dart';
import 'package:anexpress/features/store_calculation_feature/data/store_calculation_model.dart';

class StoreCalculationRepositoryException implements Exception {}

class StoreCalculationRepository {
  StoreCalculationRepository({StoreCalculationApiService? service})
      : _service = service ?? StoreCalculationApiService();
  final StoreCalculationApiService _service;

  Future<StoreCalculationModel> requestGetStoreCalcData({
    required Map<String, dynamic> requestMap,
  }) async {
    try {
      return _service.getStoreCalculationData(requestMap: requestMap);
    } on Exception {
      throw StoreCalculationRepositoryException();
    }
  }
}
