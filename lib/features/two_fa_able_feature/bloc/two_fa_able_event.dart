part of 'two_fa_able_bloc.dart';

abstract class TwoFAableEvent extends Equatable {
  const TwoFAableEvent();

  @override
  List<Object> get props => [];
}

class TwoFaAblePostEvent extends TwoFAableEvent {
  final Map<String, dynamic> requestValueMap;
  final String apiEndPoint;

  const TwoFaAblePostEvent({
    required this.requestValueMap,
    required this.apiEndPoint,
  });

  @override
  List<Object> get props => [];
}
