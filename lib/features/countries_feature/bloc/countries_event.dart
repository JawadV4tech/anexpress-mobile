part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class CountriesGetEvent extends CountriesEvent {
  const CountriesGetEvent();

  @override
  List<Object> get props => [];
}
