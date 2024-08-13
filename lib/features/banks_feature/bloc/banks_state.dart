part of 'banks_bloc.dart';

abstract class BanksState extends Equatable {
  const BanksState();
}

class BanksInitial extends BanksState {
  @override
  List<Object> get props => [];
}

class BanksLoading extends BanksState {
  @override
  List<Object> get props => [];
}

class BanksLoaded extends BanksState {
  final List<BankInfoModel> banks;

  const BanksLoaded({
    required this.banks,
  });

  @override
  List<Object?> get props => [banks];
}

class BanksError extends BanksState {
  final String errorMessage;
  const BanksError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
