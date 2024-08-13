import 'package:anexpress/features/user_search_feature/data/user_search_api_service.dart';
import 'package:anexpress/features/user_search_feature/data/search_user_model.dart';

class AreaSearchRepositoryException implements Exception {}

class UserSearchRepository {
  UserSearchRepository({UserSearchApiService? service})
      : _service = service ?? UserSearchApiService();
  final UserSearchApiService _service;

  Future<List<SearchUserModel>> requestSearchUsers({
    required int receiveCountryId,
    required int serviceId,
    required String searchQuery,
  }) async {
    try {
      //
      return _service.getUsersSearchData(
        receiveCountryId: receiveCountryId,
        serviceId: serviceId,
        searchQuery: searchQuery,
      );
      //
    } on Exception {
      throw AreaSearchRepositoryException();
    }
  }
}
