import 'package:anexpress/core/controllers/theme_controller.dart';
import 'package:anexpress/core/data/country_codes.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:get/get.dart';

void setStatusBarTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColors.primaryDark,
    ),
  );
}

List<String> getCountriesList() {
  List<String> countries = [];

  List<dynamic> data = jsonDecode(countriesList);

  for (var country in data) {
    String flag = country['flag'];
    String name = country['name'];

    String formattedString = "$flag $name";

    countries.add(formattedString);
  }

  return countries;
}

bool isLightMode() {
  return Get.find<ThemeController>().isLightMode;
}

List<String> getCountriesName(List<CountryInfoModel> countries) {
  List<String> nameList = [];

  for (var country in countries) {
    nameList.add(country.name ?? "");
  }

  return nameList;
}

int getSelectedCountryID(
    List<CountryInfoModel> countries, String selectedCountry) {
  int selectedCountryId = 0;

  for (var country in countries) {
    if (country.name == selectedCountry) {
      selectedCountryId = country.id ?? 0;
    }
  }

  return selectedCountryId;
}

String formatDouble(double value) {
  if (value % 1 == 0) {
    // No value after the decimal point, return rounded value
    return value.toStringAsFixed(0);
  } else {
    // Value after the decimal point, return with 2 decimal places
    return value.toStringAsFixed(2);
  }
}

/// Check Birth date entered is 18 years till today
bool isAdult2(DateTime birthDate) {
  //String datePattern = "dd-MM-yyyy";

  // Current time - at this moment
  DateTime today = DateTime.now();

  // Parsed date to check
  //DateTime birthDate = DateFormat(datePattern).parse(birthDateString);

  // Date to check but moved 18 years ahead
  DateTime adultDate = DateTime(
    birthDate.year + 18,
    birthDate.month,
    birthDate.day,
  );

  return adultDate.isBefore(today);
}

void closSoftKeyBoard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
