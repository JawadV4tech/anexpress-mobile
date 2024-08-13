part of 'two_fa_able_bloc.dart';

abstract class TwoFAableState extends Equatable {
  const TwoFAableState();
}

class TwoFAInitial extends TwoFAableState {
  @override
  List<Object> get props => [];
}

class TwoFAableLoading extends TwoFAableState {
  @override
  List<Object> get props => [];
}

class TwoFAableLoaded extends TwoFAableState {
  final String result;

  const TwoFAableLoaded({
    required this.result,
  });

  @override
  List<Object?> get props => [result];
}

class TwoFAableError extends TwoFAableState {
  final String errorMessage;
  const TwoFAableError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
