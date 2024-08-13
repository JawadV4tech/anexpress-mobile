// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/banks_feature/data/bank_info_model.dart';
import 'package:anexpress/features/banks_feature/data/banks_api_service.dart';

class BanksRepositoryException implements Exception {}

class BanksRepository {
  BanksRepository({BanksApiService? service})
      : _service = service ?? BanksApiService();
  final BanksApiService _service;

  Future<List<BankInfoModel>> requestGetBanksData(
      {required int receiveCountryId}) async {
    try {
      return _service.getBanksData(receiveCountryId: receiveCountryId);
    } on Exception {
      throw BanksRepositoryException();
    }
  }
}
