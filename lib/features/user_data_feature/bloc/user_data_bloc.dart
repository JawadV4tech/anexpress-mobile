import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/features/user_data_feature/data/search_user_data_model.dart';
import 'package:anexpress/features/user_data_feature/data/user_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc({required this.repository}) : super(const UserDataState()) {
    on<GetUsersDataEvent>((event, emit) async {
      // emit the loading state
      emit(state.copyWith(status: UserDataStatus.loading));

      try {
        //
        final result = await repository.requestGetUserData(
          userId: event.userId,
        );
        // emit Loaded State with Users
        emit(state.copyWith(status: UserDataStatus.success, userData: result));
        //
      } on Exception catch (e) {
        'UserDataBloc the error message received is $e'.log();

        //
        emit(state.copyWith(status: UserDataStatus.error, message: '$e'));
      }
    });
  }

  final UserDataRepository repository;
}
