part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class ServicesGetEvent extends ServicesEvent {
  const ServicesGetEvent();

  @override
  List<Object> get props => [];
}

class ServicesResetEvent extends ServicesEvent {
  const ServicesResetEvent();

  @override
  List<Object> get props => [];
}
