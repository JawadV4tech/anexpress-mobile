import 'package:anexpress/features/contact_us/data/contact_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  //
  final ContactRepository repository;

  //
  ContactBloc({required this.repository}) : super(ContactInitial()) {
    on<SubmitContactFormEvent>((event, emit) async {
      //
      emit(ContactLoading());
      //
      try {
        final result = await repository.requestSendContactEmail(
            requestValueMap: event.requestValueMap);

        emit(ContactLoaded(successMessage: result));
      } on Exception {
        emit(
          const ContactError(errorMessage: "Error Sending Contact Message"),
        );
      }
    });
  }
}
