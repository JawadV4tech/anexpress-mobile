import 'package:anexpress/features/user_data_feature/data/search_user_data_model.dart';
import 'package:anexpress/features/user_data_feature/data/user_data_api_service.dart';

class UserDataRepositoryException implements Exception {}

class UserDataRepository {
  UserDataRepository({UserDataApiService? service})
      : _service = service ?? UserDataApiService();
  final UserDataApiService _service;

  Future<SearchUserDataModel> requestGetUserData({
    required int userId,
  }) async {
    try {
      //
      return _service.getUsersDataById(userId: userId);
      //
    } on Exception {
      throw UserDataRepositoryException();
    }
  }
}
