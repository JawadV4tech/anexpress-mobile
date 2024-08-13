import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/features/user_search_feature/data/search_user_model.dart';
import 'package:anexpress/features/user_search_feature/data/user_search_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc({required this.repository}) : super(UserSearchState()) {
    on<GetUsersSearchEvent>((event, emit) async {
      // emit the loading state
      emit(state.copyWith(status: UserSearchStatus.loading));

      try {
        //
        final result = await repository.requestSearchUsers(
          receiveCountryId: event.receiveCountryId,
          serviceId: event.serviceId,
          searchQuery: event.searchQuery,
        );

        //

        // emit Loaded State with Users
        emit(state.copyWith(status: UserSearchStatus.success, users: result));
        //
      } on Exception catch (e) {
        'UserSearchBloc the error message received is $e'.log();

        //
        emit(state.copyWith(status: UserSearchStatus.error, message: '$e'));
      }
    });
  }

  final UserSearchRepository repository;
}
