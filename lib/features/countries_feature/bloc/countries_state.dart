part of 'countries_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();
}

class CountriesInitial extends CountriesState {
  @override
  List<Object> get props => [];
}

class CountriesLoading extends CountriesState {
  @override
  List<Object> get props => [];
}

class CountriesLoaded extends CountriesState {
  final List<CountryInfoModel> countries;

  const CountriesLoaded({
    required this.countries,
  });

  @override
  List<Object?> get props => [countries];
}

class CountriesError extends CountriesState {
  final String errorMessage;
  const CountriesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
