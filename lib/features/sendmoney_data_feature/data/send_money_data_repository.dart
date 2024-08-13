// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/sendmoney_data_feature/data/send_money_data_api_service.dart';

class SendMoneyDataRepositoryException implements Exception {}

class SendMoneyDataRepository {
  SendMoneyDataRepository({
    SendMoneyDataApiService? service,
  }) : _service = service ?? SendMoneyDataApiService();
  //
  final SendMoneyDataApiService _service;

  Future<int> requestGetSendMoneyData({
    required Map<String, dynamic> requestMap,
  }) async {
    try {
      //
      return _service.getSendMoneyData(requestMap: requestMap);
    } on Exception {
      throw SendMoneyDataRepositoryException();
    }
  }
}
