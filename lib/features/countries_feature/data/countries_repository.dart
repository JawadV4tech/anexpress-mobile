// throw an Exception while looking for the Store Info Data

import 'package:anexpress/features/countries_feature/data/countries_api_service.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';

class CountriesRepositoryException implements Exception {}

class CountriesRepository {
  CountriesRepository({CountriesApiService? service})
      : _service = service ?? CountriesApiService();
  final CountriesApiService _service;

  Future<List<CountryInfoModel>> requestGetServicesData() async {
    try {
      return _service.getCountriesData();
    } on Exception {
      throw CountriesRepositoryException();
    }
  }
}
