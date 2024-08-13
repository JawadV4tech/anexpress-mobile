import 'package:anexpress/features/logout_feature/data/logout_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc({required this.repository}) : super(LogoutInitial()) {
    on<LogoutEvent>(_onPerformUserLogout);
  }

  final LogoutRepository repository;

  void _onPerformUserLogout(event, emit) async {
    try {
      emit(LogoutLoading());

      final logoutResult = await repository.requestUserLogout();

      emit(LogoutLoaded(isLoggedOut: true, message: logoutResult));
    } on Exception catch (e) {
      emit(LogoutError(errorMessage: '$e'));
    }
  }
}
