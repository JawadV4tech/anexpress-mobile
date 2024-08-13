// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/services_feature/data/service_info_model.dart';
import 'package:anexpress/features/services_feature/data/services_api_service.dart';

class ServicesRepositoryException implements Exception {}

class ServicesRepository {
  ServicesRepository({ServicesApiService? service})
      : _service = service ?? ServicesApiService();
  final ServicesApiService _service;

  Future<List<ServiceInfoModel>> requestGetServicesData() async {
    try {
      return _service.getServicesData();
    } on Exception {
      throw ServicesRepositoryException();
    }
  }
}
