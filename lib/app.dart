import 'dart:io';

import 'package:anexpress/core/models/language_model.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/banks_feature/bloc/banks_bloc.dart';
import 'package:anexpress/features/banks_feature/data/banks_repository.dart';
import 'package:anexpress/features/branches_feature/bloc/branches_bloc.dart';
import 'package:anexpress/features/branches_feature/data/branches_repository.dart';
import 'package:anexpress/features/calculation_feature/bloc/calculation_bloc.dart';
import 'package:anexpress/features/calculation_feature/data/calculation_repository.dart';
import 'package:anexpress/features/contact_us/bloc/contact_bloc.dart';
import 'package:anexpress/features/contact_us/data/contact_repository.dart';
import 'package:anexpress/features/countries_feature/bloc/countries_bloc.dart';
import 'package:anexpress/features/countries_feature/data/countries_repository.dart';
import 'package:anexpress/features/discount_feature/bloc/discount_bloc.dart';
import 'package:anexpress/features/discount_feature/data/discount_repository.dart';
import 'package:anexpress/features/gateway_detail_feature/bloc/gateway_detail_bloc.dart';
import 'package:anexpress/features/gateway_detail_feature/data/gateway_detail_repository.dart';
import 'package:anexpress/features/gateways_feature/bloc/gateway_bloc.dart';
import 'package:anexpress/features/gateways_feature/data/gateways_repository.dart';
import 'package:anexpress/features/login/bloc/login_bloc.dart';
import 'package:anexpress/features/login/data/login_repository.dart';
import 'package:anexpress/features/logout_feature/bloc/logout_bloc.dart';
import 'package:anexpress/features/logout_feature/data/logout_repository.dart';
import 'package:anexpress/features/payment_card_feature/bloc/payment_card_bloc.dart';
import 'package:anexpress/features/payment_card_feature/data/payment_card_repository.dart';
import 'package:anexpress/features/payment_manually_feature/bloc/payment_manually_bloc.dart';
import 'package:anexpress/features/payment_manually_feature/data/store_calculation_repository.dart';
import 'package:anexpress/features/privacy_policy_screen/bloc/privacy_bloc.dart';
import 'package:anexpress/features/privacy_policy_screen/data/privacy_repository.dart';
import 'package:anexpress/features/recipient_feature/bloc/recipient_bloc.dart';
import 'package:anexpress/features/recipient_feature/data/recipient_repository.dart';
import 'package:anexpress/features/register/bloc/register_bloc.dart';
import 'package:anexpress/features/register/data/register_repository.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:anexpress/features/sendmoney_data_feature/bloc/send_money_data_bloc.dart';
import 'package:anexpress/features/sendmoney_data_feature/data/send_money_data_repository.dart';
import 'package:anexpress/features/services_feature/bloc/services_bloc.dart';
import 'package:anexpress/features/services_feature/data/services_repository.dart';
import 'package:anexpress/features/store_calculation_feature/bloc/store_calculation_bloc.dart';
import 'package:anexpress/features/store_calculation_feature/data/store_calculation_repository.dart';
import 'package:anexpress/features/two_fa_able_feature/bloc/two_fa_able_bloc.dart';
import 'package:anexpress/features/two_fa_able_feature/data/two_fa_able_repository.dart';
import 'package:anexpress/features/two_fa_security_screen/bloc/two_fa_bloc.dart';
import 'package:anexpress/features/two_fa_security_screen/data/two_fa_repository.dart';
import 'package:anexpress/features/user_data_feature/bloc/user_data_bloc.dart';
import 'package:anexpress/features/user_data_feature/data/user_data_repository.dart';
import 'package:anexpress/features/user_search_feature/bloc/user_search_bloc.dart';
import 'package:anexpress/features/user_search_feature/data/user_search_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/controllers/theme_controller.dart';
import 'package:anexpress/core/themes/themes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:stacked_services/stacked_services.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Loc>(
      builder: (locController) {
        return GetBuilder<ThemeController>(builder: (controller) {
          final ThemeData theme = AppTheme.getThemeData;
          return MultiRepositoryProvider(
            providers: [
              //LoginRepository
              RepositoryProvider<LoginRepository>(
                create: ((context) => LoginRepository()),
              ),
              //LoginRepository
              RepositoryProvider<RegisterRepository>(
                create: ((context) => RegisterRepository()),
              ),
              //LogoutRepository
              RepositoryProvider<LogoutRepository>(
                create: ((context) => LogoutRepository()),
              ),
              //ServicesRepository
              RepositoryProvider<ServicesRepository>(
                create: ((context) => ServicesRepository()),
              ),
              //CountriesRepository
              RepositoryProvider<CountriesRepository>(
                create: ((context) => CountriesRepository()),
              ),
              //BanksRepository
              RepositoryProvider<BanksRepository>(
                create: ((context) => BanksRepository()),
              ),
              //ContactRepository
              RepositoryProvider<ContactRepository>(
                create: ((context) => ContactRepository()),
              ),
              //PrivacyRepository
              RepositoryProvider<PrivacyRepository>(
                create: ((context) => PrivacyRepository()),
              ),

              //TwoFARepository
              RepositoryProvider<TwoFARepository>(
                create: ((context) => TwoFARepository()),
              ),
              //TwoFAableRepository
              RepositoryProvider<TwoFAableRepository>(
                create: ((context) => TwoFAableRepository()),
              ),
              //SendMoneyRepository
              RepositoryProvider<CalculationRepository>(
                create: ((context) => CalculationRepository()),
              ),
              //BranchesRepository
              RepositoryProvider<BranchesRepository>(
                create: ((context) => BranchesRepository()),
              ),
              //StoreCalculationRepository
              RepositoryProvider<StoreCalculationRepository>(
                create: ((context) => StoreCalculationRepository()),
              ),
              //RecipientRepository
              RepositoryProvider<RecipientRepository>(
                create: ((context) => RecipientRepository()),
              ),
              //DiscountRepository
              RepositoryProvider<DiscountRepository>(
                create: ((context) => DiscountRepository()),
              ),
              //SendMoneyDataRepository
              RepositoryProvider<SendMoneyDataRepository>(
                create: ((context) => SendMoneyDataRepository()),
              ),
              //GateWaysRepository
              RepositoryProvider<GateWaysRepository>(
                create: ((context) => GateWaysRepository()),
              ),
              //GateWayDetailRepository
              RepositoryProvider<GateWayDetailRepository>(
                create: ((context) => GateWayDetailRepository()),
              ),
              //PaymentManuallyRepository
              RepositoryProvider<PaymentManuallyRepository>(
                create: ((context) => PaymentManuallyRepository()),
              ),
              //PaymentCardRepository
              RepositoryProvider<PaymentCardRepository>(
                create: ((context) => PaymentCardRepository()),
              ),
              //UserSearchRepository
              RepositoryProvider<UserSearchRepository>(
                create: ((context) => UserSearchRepository()),
              ),
              //UserDataRepository
              RepositoryProvider<UserDataRepository>(
                create: ((context) => UserDataRepository()),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                //LoginBloc
                BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(
                    repository: context.read<LoginRepository>(),
                  ),
                ),
                //RegisterBloc
                BlocProvider<RegisterBloc>(
                  create: (context) => RegisterBloc(
                    repository: context.read<RegisterRepository>(),
                  ),
                ),
                //LogoutBloc
                BlocProvider<LogoutBloc>(
                  create: (context) => LogoutBloc(
                    repository: context.read<LogoutRepository>(),
                  ),
                ),
                //ServicesBloc
                BlocProvider<ServicesBloc>(
                  create: (context) => ServicesBloc(
                    repository: context.read<ServicesRepository>(),
                  ),
                ),
                //CountriesBloc
                BlocProvider<CountriesBloc>(
                  create: (context) => CountriesBloc(
                    repository: context.read<CountriesRepository>(),
                  ),
                ),
                //BanksBloc
                BlocProvider<BanksBloc>(
                  create: (context) => BanksBloc(
                    repository: context.read<BanksRepository>(),
                  ),
                ),
                //ContactBloc
                BlocProvider<ContactBloc>(
                  create: (context) => ContactBloc(
                    repository: context.read<ContactRepository>(),
                  ),
                ),
                //PrivacyBloc
                BlocProvider<PrivacyBloc>(
                  create: (context) => PrivacyBloc(
                    repository: context.read<PrivacyRepository>(),
                  ),
                ),
                //TwoFABloc
                BlocProvider<TwoFABloc>(
                  create: (context) => TwoFABloc(
                    repository: context.read<TwoFARepository>(),
                  ),
                ),
                //TwoFABloc
                BlocProvider<TwoFAableBloc>(
                  create: (context) => TwoFAableBloc(
                    repository: context.read<TwoFAableRepository>(),
                  ),
                ),
                //SendMoneyBloc
                BlocProvider<SendMoneyBloc>(
                  create: (context) => SendMoneyBloc(),
                ),
                //BranchesBloc
                BlocProvider<BranchesBloc>(
                  create: (context) => BranchesBloc(
                    repository: context.read<BranchesRepository>(),
                  ),
                ),
                //CalculationBloc
                BlocProvider<CalculationBloc>(
                  create: (context) => CalculationBloc(
                    repository: context.read<CalculationRepository>(),
                  ),
                ),
                //CalculationBloc
                BlocProvider<StoreCalculationBloc>(
                  create: (context) => StoreCalculationBloc(
                    repository: context.read<StoreCalculationRepository>(),
                  ),
                ),
                //RecipientBloc
                BlocProvider<RecipientBloc>(
                  create: (context) => RecipientBloc(
                    repository: context.read<RecipientRepository>(),
                  ),
                ),
                //DiscountBloc
                BlocProvider<DiscountBloc>(
                  create: (context) => DiscountBloc(
                    repository: context.read<DiscountRepository>(),
                  ),
                ),
                //SendMoneyBloc
                BlocProvider<SendMoneyDataBloc>(
                  create: (context) => SendMoneyDataBloc(
                    repository: context.read<SendMoneyDataRepository>(),
                  ),
                ),
                //GatewayBloc
                BlocProvider<GatewayBloc>(
                  create: (context) => GatewayBloc(
                    repository: context.read<GateWaysRepository>(),
                  ),
                ),
                //GatewayDetailBloc
                BlocProvider<GatewayDetailBloc>(
                  create: (context) => GatewayDetailBloc(
                    repository: context.read<GateWayDetailRepository>(),
                  ),
                ),

                //PaymentManuallyBloc
                BlocProvider<PaymentManuallyBloc>(
                  create: (context) => PaymentManuallyBloc(
                    repository: context.read<PaymentManuallyRepository>(),
                  ),
                ),
                //PaymentCardRepository
                BlocProvider<PaymentCardBloc>(
                  create: (context) => PaymentCardBloc(
                    repository: context.read<PaymentCardRepository>(),
                  ),
                ),
                //UserSearchBloc
                BlocProvider<UserSearchBloc>(
                  create: (context) => UserSearchBloc(
                    repository: context.read<UserSearchRepository>(),
                  ),
                ),
                //UserDataBloc
                BlocProvider<UserDataBloc>(
                  create: (context) => UserDataBloc(
                    repository: context.read<UserDataRepository>(),
                  ),
                ),
              ],
              child: MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: getLocalesFromLanguageModels(),
                locale: locController.locale,
                title: 'A N Express',
                debugShowCheckedModeBanner: false,
                theme: theme,
                routes: AppRoutes.routes,
                initialRoute: AppRoutes.splashScreen,
                navigatorKey: StackedService.navigatorKey,
                builder: (BuildContext context, Widget? child) {
                  _setFirstTimeSomeData(context, theme);
                  return Directionality(
                    textDirection: locController.locale.languageCode == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: MediaQuery(
                      key: ValueKey(
                          'languageCode ${locController.locale.languageCode}'),
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: MediaQuery.of(context).size.width > 360
                            ? 1.0
                            : MediaQuery.of(context).size.width >= 340
                                ? 0.9
                                : 0.8,
                      ),
                      child: child ?? const SizedBox(),
                    ),
                  );
                },
              ),
            ),
          );
        });
      },
    );
  }

// when this application open every time on that time we check and update some theme data
  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    _setStatusBarNavigationBarTheme(theme);
    //we call some theme basic data set in app like color, font, theme mode, language
    Get.find<ThemeController>()
        .checkAndSetThemeMode(MediaQuery.of(context).platformBrightness);
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.colorScheme.background,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }
}
