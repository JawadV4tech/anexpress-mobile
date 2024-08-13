part of 'user_search_bloc.dart';

enum UserSearchStatus { initial, success, error, loading }

extension UserSearchStatusX on UserSearchStatus {
  bool get isInitial => this == UserSearchStatus.initial;
  bool get isSuccess => this == UserSearchStatus.success;
  bool get isError => this == UserSearchStatus.error;
  bool get isLoading => this == UserSearchStatus.loading;
}

class UserSearchState extends Equatable {
  final List<SearchUserModel> users;
  final UserSearchStatus status;
  final String message;

  UserSearchState({
    this.status = UserSearchStatus.initial,
    this.message = "",
    List<SearchUserModel>? users,
  }) : users = users ?? [];

  @override
  List<Object?> get props => [status, users, message];

  UserSearchState copyWith({
    List<SearchUserModel>? users,
    UserSearchStatus? status,
    String? message,
  }) {
    return UserSearchState(
      status: status ?? this.status,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }
}
