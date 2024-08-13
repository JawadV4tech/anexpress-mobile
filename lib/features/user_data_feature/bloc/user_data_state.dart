part of 'user_data_bloc.dart';

enum UserDataStatus { initial, success, error, loading }

extension UserDataStatusX on UserDataStatus {
  bool get isInitial => this == UserDataStatus.initial;
  bool get isSuccess => this == UserDataStatus.success;
  bool get isError => this == UserDataStatus.error;
  bool get isLoading => this == UserDataStatus.loading;
}

class UserDataState extends Equatable {
  final SearchUserDataModel userData;
  final UserDataStatus status;
  final String message;

  const UserDataState({
    this.status = UserDataStatus.initial,
    this.message = "",
    SearchUserDataModel? userData,
  }) : userData = userData ?? const SearchUserDataModel();

  @override
  List<Object?> get props => [status, userData, message];

  UserDataState copyWith({
    SearchUserDataModel? userData,
    UserDataStatus? status,
    String? message,
  }) {
    return UserDataState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
      message: message ?? this.message,
    );
  }
}
