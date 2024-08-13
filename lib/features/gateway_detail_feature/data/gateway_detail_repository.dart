// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/gateway_detail_feature/data/gateway_detail_api_service.dart';
import 'package:anexpress/features/gateway_detail_feature/data/gateway_detail_model.dart';

class GateWayDetailRepositoryException implements Exception {}

class GateWayDetailRepository {
  GateWayDetailRepository({GateWayDetailApiService? service})
      : _service = service ?? GateWayDetailApiService();

  final GateWayDetailApiService _service;

  Future<GatewayDetailModel> requestGetGatewayDetailData({
    required Map<String, dynamic> requestMap,
  }) async {
    try {
      return _service.getGatewayDetailData(requestMap: requestMap);
    } on Exception {
      throw GateWayDetailRepositoryException();
    }
  }
}
