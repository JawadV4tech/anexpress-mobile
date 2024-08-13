part of 'branches_bloc.dart';

abstract class BranchesState extends Equatable {
  const BranchesState();
}

class BranchesInitial extends BranchesState {
  @override
  List<Object> get props => [];
}

class BranchesLoading extends BranchesState {
  @override
  List<Object> get props => [];
}

class BranchesLoaded extends BranchesState {
  final List<BankBranchInfoModel> branches;

  const BranchesLoaded({
    required this.branches,
  });

  @override
  List<Object?> get props => [branches];
}

class BranchesError extends BranchesState {
  final String errorMessage;
  const BranchesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
