// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/payment_card_feature/data/payment_card_response_model.dart';
import 'package:anexpress/features/payment_card_feature/data/payment_card_api_service.dart';

class PaymentCardRepositoryException implements Exception {}

class PaymentCardRepository {
  PaymentCardRepository({PaymentCardApiService? service})
      : _service = service ?? PaymentCardApiService();
  final PaymentCardApiService _service;

  Future<PaymentCardResponseModel> requestPerformPaymentManually({
    required Map<String, dynamic> requestMap,
  }) async {
    try {
      return _service.performPaymentManually(requestMap: requestMap);
    } on Exception {
      throw PaymentCardRepositoryException();
    }
  }
}
