part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class SubmitContactFormEvent extends ContactEvent {
  final Map<String, dynamic> requestValueMap;

  const SubmitContactFormEvent({
    required this.requestValueMap,
  });

  @override
  List<Object> get props => [requestValueMap];
}
