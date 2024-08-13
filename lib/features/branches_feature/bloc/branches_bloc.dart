import 'dart:async';

import 'package:anexpress/features/branches_feature/data/bank_branch_info_model.dart';
import 'package:anexpress/features/branches_feature/data/branches_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'branches_event.dart';
part 'branches_state.dart';

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  BranchesBloc({required this.repository}) : super(BranchesInitial()) {
    on<BranchesGetEvent>(_onBanksGetEvent);
    on<BranchesResetEvent>(_onBranchesResetEvent);

    //BranchesResetEvent
  }

  final BranchesRepository repository;
  FutureOr<void> _onBanksGetEvent(
      BranchesGetEvent event, Emitter<BranchesState> emit) async {
    try {
      emit(BranchesLoading());

      final data = await repository.requestGetBanksData(bankId: event.bankId);

      emit(BranchesLoaded(branches: data));
    } on Exception catch (e) {
      emit(BranchesError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onBranchesResetEvent(
      BranchesResetEvent event, Emitter<BranchesState> emit) {
    emit(BranchesInitial());
  }
}
