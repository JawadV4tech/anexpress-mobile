part of 'user_search_bloc.dart';

abstract class UserSearchEvent extends Equatable {
  const UserSearchEvent();

  @override
  List<Object> get props => [];
}

class GetUsersSearchEvent extends UserSearchEvent {
  const GetUsersSearchEvent({
    required this.receiveCountryId,
    required this.serviceId,
    required this.searchQuery,
  });

  final int receiveCountryId;
  final int serviceId;
  final String searchQuery;

  @override
  List<Object> get props => [receiveCountryId, serviceId, searchQuery];
}
