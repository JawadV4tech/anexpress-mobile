// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/branches_feature/data/bank_branch_info_model.dart';
import 'package:anexpress/features/branches_feature/data/branches_api_service.dart';

class BranchesRepositoryException implements Exception {}

class BranchesRepository {
  BranchesRepository({BranchesApiService? service})
      : _service = service ?? BranchesApiService();
  final BranchesApiService _service;

  Future<List<BankBranchInfoModel>> requestGetBanksData(
      {required int bankId}) async {
    try {
      return _service.getBanksData(bankId: bankId);
    } on Exception {
      throw BranchesRepositoryException();
    }
  }
}
