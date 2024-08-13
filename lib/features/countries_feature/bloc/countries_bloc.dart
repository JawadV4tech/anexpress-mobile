import 'dart:async';

import 'package:anexpress/features/countries_feature/data/countries_repository.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc({required this.repository}) : super(CountriesInitial()) {
    on<CountriesGetEvent>(_onCountriesGetEvent);
  }

  final CountriesRepository repository;
  FutureOr<void> _onCountriesGetEvent(
      CountriesGetEvent event, Emitter<CountriesState> emit) async {
    try {
      emit(CountriesLoading());

      final countriesData = await repository.requestGetServicesData();

      emit(CountriesLoaded(countries: countriesData));
    } on Exception catch (e) {
      emit(CountriesError(errorMessage: e.toString()));
    }
  }
}
