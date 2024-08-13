part of 'branches_bloc.dart';

abstract class BranchesEvent extends Equatable {
  const BranchesEvent();

  @override
  List<Object> get props => [];
}

class BranchesGetEvent extends BranchesEvent {
  final int bankId;
  const BranchesGetEvent({required this.bankId});

  @override
  List<Object> get props => [bankId];
}

class BranchesResetEvent extends BranchesEvent {
  const BranchesResetEvent();

  @override
  List<Object> get props => [];
}
