import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/register/data/register_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.repository}) : super(RegisterInitial()) {
    on<PerformUserRegister>(_onPerformUserLogin);
  }

  final RegisterRepository repository;

  void _onPerformUserLogin(event, emit) async {
    try {
      // emit the loading state
      emit(RegisterLoading());

      final result = await repository.requestUserRegister(
        requestValueMap: event.requestValueMap,
      );

      // Save Token in Shared Preference
      await SharedPreferencesHelpers()
          .setStringData(key: PrefKeys.authTokenPrefKey, text: result);

      // emit RegisterLoaded State
      emit(RegisterLoaded(isRegister: true, token: result));
    } on Exception catch (e) {
      emit(RegisterError(errorMessage: e.toString()));
    }
  }
}
