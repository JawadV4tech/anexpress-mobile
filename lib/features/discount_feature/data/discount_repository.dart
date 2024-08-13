// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/discount_feature/data/discount_api_service.dart';

class DiscountRepositoryException implements Exception {}

class DiscountRepository {
  DiscountRepository({
    DiscountApiService? service,
  }) : _service = service ?? DiscountApiService();
  //
  final DiscountApiService _service;

  Future<double> requestGetDiscountData(
      {required Map<String, dynamic> requestMap,
      required String apiUrl}) async {
    try {
      return _service.getDiscountData(
        requestMap: requestMap,
        apiUrl: apiUrl,
      );
    } on Exception {
      throw DiscountRepositoryException();
    }
  }
}
