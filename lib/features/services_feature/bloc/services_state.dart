part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
}

class ServicesInitial extends ServicesState {
  @override
  List<Object> get props => [];
}

class ServicesLoading extends ServicesState {
  @override
  List<Object> get props => [];
}

class ServicesLoaded extends ServicesState {
  final List<ServiceInfoModel> services;

  const ServicesLoaded({
    required this.services,
  });

  @override
  List<Object?> get props => [services];
}

class ServicesError extends ServicesState {
  final String errorMessage;
  const ServicesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
