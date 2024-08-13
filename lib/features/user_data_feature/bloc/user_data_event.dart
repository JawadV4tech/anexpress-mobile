part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class GetUsersDataEvent extends UserDataEvent {
  const GetUsersDataEvent({
    required this.userId,
  });

  final int userId;

  @override
  List<Object> get props => [userId];
}
