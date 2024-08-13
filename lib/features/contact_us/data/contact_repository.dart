import 'package:anexpress/features/contact_us/data/contact_api_service.dart';

class ContactRepositoryException implements Exception {}

class ContactRepository {
  ContactRepository({ContactApiService? service})
      : _service = service ?? ContactApiService();
  final ContactApiService _service;

  Future<String> requestSendContactEmail({
    required Map<String, dynamic> requestValueMap,
  }) async {
    try {
      return _service.sendContactEmail(requestValueMap: requestValueMap);
    } on Exception {
      throw ContactRepositoryException();
    }
  }
}
