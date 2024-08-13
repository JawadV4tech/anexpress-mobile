// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/recipient_feature/data/recipient_api_service.dart';
import 'package:anexpress/features/recipient_feature/data/send_money_recipient_model.dart';

class ReceipientRepositoryException implements Exception {}

class RecipientRepository {
  RecipientRepository({ReceipientApiService? service})
      : _service = service ?? ReceipientApiService();
  final ReceipientApiService _service;

  Future<SendMoneyRecipientModel> requestGetRecipientData({
    required int id,
  }) async {
    try {
      return _service.getRecipientSendMoneyData(id: id);
    } on Exception {
      throw ReceipientRepositoryException();
    }
  }
}
