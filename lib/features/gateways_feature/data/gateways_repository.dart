// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/gateways_feature/data/gateways_model.dart';
import 'package:anexpress/features/gateways_feature/data/gateways_api_service.dart';

class GateWaysRepositoryException implements Exception {}

class GateWaysRepository {
  GateWaysRepository({GateWaysApiService? service})
      : _service = service ?? GateWaysApiService();
  final GateWaysApiService _service;

  Future<GatewaysModel> requestGetGatewaysData() async {
    try {
      return _service.getGateWaysData();
    } on Exception {
      throw GateWaysRepositoryException();
    }
  }
}
