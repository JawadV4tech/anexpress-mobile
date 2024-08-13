part of 'two_fa_bloc.dart';

abstract class TwoFAState extends Equatable {
  const TwoFAState();
}

class TwoFAInitial extends TwoFAState {
  @override
  List<Object> get props => [];
}

class TwoFALoading extends TwoFAState {
  @override
  List<Object> get props => [];
}

class TwoFALoaded extends TwoFAState {
  final TwoFAInfoModel twoInfoData;

  const TwoFALoaded({
    required this.twoInfoData,
  });

  @override
  List<Object?> get props => [twoInfoData];
}

class TwoFAError extends TwoFAState {
  final String errorMessage;
  const TwoFAError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
