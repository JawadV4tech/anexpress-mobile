part of 'recipient_bloc.dart';

abstract class RecipientEvent extends Equatable {
  const RecipientEvent();

  @override
  List<Object> get props => [];
}

class GetSendMoneyRecipientEvent extends RecipientEvent {
  final int id;

  const GetSendMoneyRecipientEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
