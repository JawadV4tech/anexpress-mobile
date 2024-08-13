import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/banks_feature/bloc/banks_bloc.dart';
import 'package:anexpress/features/branches_feature/bloc/branches_bloc.dart';
import 'package:anexpress/features/calculation_feature/bloc/calculation_bloc.dart';
import 'package:anexpress/features/countries_feature/bloc/countries_bloc.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:anexpress/features/services_feature/bloc/services_bloc.dart';
import 'package:anexpress/widgets/country_drop_down.dart';
import 'package:anexpress/widgets/overlay_animated_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectToFromView extends StatelessWidget {
  const SelectToFromView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          if (state is CountriesLoading) {
            return Padding(
              padding: getPadding(bottom: 170),
              child: const OverLayAnimatedSpinner(),
            );
          }
          if (state is CountriesLoaded) {
            return SendMoneyOneToFromChildWidget(
              countriesList: state.countries,
            );
          }

          if (state is CountriesError) {
            return Center(
              child: ErrorMessageWithRetryButton(
                message: state.errorMessage,
                onTap: () {
                  // call the CountriesGetEvent
                  context.read<CountriesBloc>().add(const CountriesGetEvent());
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

// List<CountryInfoModel> countriesList = [
//   const CountryInfoModel(id: 1, name: "United Kingdom"),
//   const CountryInfoModel(id: 2, name: "Bangladesh"),
//   const CountryInfoModel(id: 3, name: "India"),
// ];

// ignore_for_file: must_be_immutable
class SendMoneyOneToFromChildWidget extends StatefulWidget {
  const SendMoneyOneToFromChildWidget({super.key, required this.countriesList});

  final List<CountryInfoModel> countriesList;

  @override
  State<SendMoneyOneToFromChildWidget> createState() =>
      _SendMoneyOneToFromChildWidgetState();
}

class _SendMoneyOneToFromChildWidgetState
    extends State<SendMoneyOneToFromChildWidget> {
  int selectedToCountryId = 0;
  int selectedFromCountryId = 0;

  String sendingFromCountry = "";
  String _errorFromSelection = "";
  String sendingToCountry = "";
  String _errorToSelection = "";

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme();
    return Container(
      width: double.maxFinite,
      padding: getPadding(left: 13, top: 0, right: 13, bottom: 23),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(left: 2, top: 40),
              child: const Text24SemiBold("Where do you want to send money?"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: getPadding(top: 2, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(left: 4, top: 46),
                        child: const Text20Medium("Sending From"),
                      ),
                      CountryDropDown(
                        width: size.width,
                        focusNode: FocusNode(),
                        autofocus: true,
                        icon: Container(
                            margin: getMargin(left: 21, right: 11),
                            child: CustomImageView(
                              svgPath: LocalFiles.imgArrowdown,
                            )),
                        hintText: "Select Sending from Country",
                        margin: getMargin(top: 0),
                        items: widget.countriesList
                            .where(
                                (country) => country.name != sendingToCountry)
                            .toList(),
                        onChanged: (fromCountry) {
                          "value received $fromCountry".log();

                          // update state
                          context.read<SendMoneyBloc>().add(
                                UpdateFromCountryEvent(
                                    sendFromCountryInfo: fromCountry),
                              );
                          setState(() {
                            sendingFromCountry = fromCountry.name ?? "";
                            selectedFromCountryId = fromCountry.id ?? 0;
                          });
                          // generate Calculation Bloc

                          //context.read<SendBloc>().add(GetBranches)
                        },
                      ),
                      if (_errorFromSelection != "")
                        RedErrorText(message: _errorFromSelection),
                      Padding(
                        padding: getPadding(left: 4, top: 25),
                        child: const Text20Medium("Sending To"),
                      ),
                      CountryDropDown(
                        width: size.width,
                        focusNode: FocusNode(),
                        autofocus: true,
                        icon: Container(
                            margin: getMargin(left: 21, right: 11),
                            child: CustomImageView(
                              svgPath: LocalFiles.imgArrowdown,
                            )),
                        hintText: "Select Sending To Country",
                        margin: getMargin(top: 0),
                        items: widget.countriesList
                            .where(
                                (country) => country.name != sendingFromCountry)
                            .toList(),
                        onChanged: (toCountry) {
                          "value received $toCountry".log();
                          // update state
                          context.read<SendMoneyBloc>().add(
                                UpdateToCountryEvent(
                                    sendToCountryInfo: toCountry),
                              );

                          setState(() {
                            sendingToCountry = toCountry.name ?? "";
                            selectedToCountryId = toCountry.id ?? 0;
                          });
                          // generate Calculation Bloc

                          //context.read<SendBloc>().add(GetBranches)
                        },
                      ),
                      if (_errorToSelection != "")
                        RedErrorText(message: _errorToSelection),
                    ],
                  ),
                ),
              ],
            ),
            const VerticalSpace(40),
            LargeButtonSecondaryColor(
              marginLeft: 0,
              marginRight: 0,
              title: Loc.alized.lbl_next,
              onTap: () {
                if (_allValidation()) {
                  // services get event
                  context.read<ServicesBloc>().add(const ServicesGetEvent());

                  // Reset Banks, Branches and Calculations Blocs States
                  context.read<BanksBloc>().add(const BanksResetEvent());
                  context.read<BranchesBloc>().add(const BranchesResetEvent());
                  context
                      .read<CalculationBloc>()
                      .add(const CalculationResetEvent());
                  // navigate to Tab 2 ServiceBankBranchCalculationView
                  context
                      .read<SendMoneyBloc>()
                      .add(const UpdateTabEvent(activeTabIndex: 1));
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }

  List<String> getSendingCountriesName(
    List<CountryInfoModel> countries,
    String sendToCountryName,
  ) {
    List<String> nameList = [];

    for (var country in countries) {
      if (sendToCountryName != country.name) {
        nameList.add(country.name ?? "");
      }
    }

    return nameList;
  }

  List<String> getToCountriesName(
    List<CountryInfoModel> countries,
    String sendFromCountryName,
  ) {
    List<String> nameList = [];

    for (var country in countries) {
      if (sendFromCountryName != country.name) {
        nameList.add(country.name ?? "");
      }
    }

    return nameList;
  }

  bool _allValidation() {
    bool isValid = true;

    if (sendingFromCountry == "Select Country") {
      isValid = false;
      _errorFromSelection = "Required";
    } else {
      _errorFromSelection = "";
    }

    if (sendingToCountry == "Select Country") {
      isValid = false;
      _errorToSelection = "Required";
    } else {
      _errorToSelection = "";
    }

    setState(() {});
    return isValid;
  }
}
