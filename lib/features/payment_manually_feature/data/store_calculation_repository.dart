// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/payment_manually_feature/data/payment_manually_api_service.dart';

class PaymentManuallyRepositoryException implements Exception {}

class PaymentManuallyRepository {
  PaymentManuallyRepository({PaymentManuallyApiService? service})
      : _service = service ?? PaymentManuallyApiService();
  final PaymentManuallyApiService _service;

  Future<String> requestPerformPaymentManually({
    required Map<String, dynamic> requestMap,
  }) async {
    try {
      return _service.performPaymentManually(requestMap: requestMap);
    } on Exception {
      throw PaymentManuallyRepositoryException();
    }
  }
}
