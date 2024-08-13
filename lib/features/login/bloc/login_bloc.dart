import 'package:anexpress/features/login/data/login_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/features/login/data/login_repository.dart';
import 'package:anexpress/features/login/data/user_info_model.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<PerformUserLogin>(_onPerformUserLogin);
  }

  final SharedPreferencesHelpers _sharedPrefKeys =
      locator<SharedPreferencesHelpers>();

  void _onPerformUserLogin(PerformUserLogin event, emit) async {
    try {
      // emit the loading state
      emit(LoginLoading());

      LoginResponseModel result = await repository.requestUserLogin(
        requestValueMap: event.requestValueMap,
        loginApiEndpoint: event.apiEndPoint,
      );

      // Save Token in Shared Preferences
      _sharedPrefKeys.setStringData(
          key: PrefKeys.authTokenPrefKey, text: result.accessToken ?? "");

      emit(LoginLoaded(userInfo: result.user!));
    } on Exception catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }
}
