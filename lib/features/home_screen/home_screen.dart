import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/core/routes/app_routes.dart';
import 'package:anexpress/features/home_screen/components/home_features_list.dart';
import 'package:anexpress/features/home_screen/components/home_header_widget.dart';
import 'package:anexpress/features/home_sidebar_menu_screen/home_sidebar_menu_screen.dart';
import 'package:anexpress/features/logout_feature/bloc/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _snackBarService = locator<SnackbarService>();
  // final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: HomeSidebarMenuScreen(),
      ),
      body: SafeArea(
        child: BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) async {
            "the state is $state".log();
            if (state is LogoutLoading) {
              LoadingScreen().show(
                context: context,
                text: 'Please wait a moment',
              );
            } else {
              LoadingScreen().hide();
            }

            // if Success

            if (state is LogoutLoaded) {
              _snackBarService.showSnackbar(
                duration: const Duration(seconds: 2),
                title: "Success",
                message: state.message,
              );

              await Future.delayed(const Duration(seconds: 2));

              _navigationService
                  .pushNamedAndRemoveUntil(AppRoutes.splashScreen);
            }

            if (state is LogoutError) {
              // await _dialogService.showCustomDialog(
              //   variant: DialogType.Generic,
              //   title: "Error",
              //   description: state.errorMessage,
              // );

              _navigationService
                  .pushNamedAndRemoveUntil(AppRoutes.splashScreen);
            }
          },
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                HomeFeaturesList(),
                HomeHeaderWidget(openDrawer: openDrawer),
                //const HomeBalanceInfoWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
