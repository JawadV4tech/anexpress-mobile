part of 'banks_bloc.dart';

abstract class BanksEvent extends Equatable {
  const BanksEvent();

  @override
  List<Object> get props => [];
}

class BanksGetEvent extends BanksEvent {
  const BanksGetEvent({required this.receiveCountryId});

  final int receiveCountryId;

  @override
  List<Object> get props => [receiveCountryId];
}

class BanksResetEvent extends BanksEvent {
  const BanksResetEvent();

  @override
  List<Object> get props => [];
}
