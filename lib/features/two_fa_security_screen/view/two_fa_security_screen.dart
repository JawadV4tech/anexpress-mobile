// ignore_for_file: use_build_context_synchronously

import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/enums/dialog_type.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/login/bloc/login_bloc.dart';
import 'package:anexpress/features/two_fa_able_feature/bloc/two_fa_able_bloc.dart';
import 'package:anexpress/features/two_fa_able_feature/view/otp_input_bottom_sheet.dart';
import 'package:anexpress/features/two_fa_security_screen/bloc/two_fa_bloc.dart';
import 'package:anexpress/features/two_fa_security_screen/data/two_fa_info_model.dart';
import 'package:anexpress/widgets/overlay_animated_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';

class TwoFASecurityScreen extends StatelessWidget {
  const TwoFASecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyWalletAppBar(titleText: "2FA Security"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<TwoFABloc, TwoFAState>(
                builder: (context, state) {
                  if (state is TwoFALoading) {
                    return Padding(
                      padding: getPadding(top: 300),
                      child: const OverLayAnimatedSpinner(),
                    );
                  }
                  if (state is TwoFALoaded) {
                    return TwoFASecurityChildWidget(
                        twoFAInfoModel: state.twoInfoData);
                  }

                  if (state is TwoFAError) {
                    return Center(child: Text(state.errorMessage));
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwoFASecurityChildWidget extends StatefulWidget {
  const TwoFASecurityChildWidget({super.key, required this.twoFAInfoModel});

  final TwoFAInfoModel twoFAInfoModel;

  @override
  State<TwoFASecurityChildWidget> createState() =>
      _TwoFASecurityChildWidgetState();
}

class _TwoFASecurityChildWidgetState extends State<TwoFASecurityChildWidget> {
  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final SharedPreferencesHelpers _sharedPrefKeys =
      locator<SharedPreferencesHelpers>();

  int temp2FaStatus = 0;

  @override
  void initState() {
    super.initState();

    checkTemp2FaStatus();
  }

  checkTemp2FaStatus() async {
    // Save Status in Shared Preferences

    final result =
        await _sharedPrefKeys.getIntData(key: PrefKeys.tempTwoFaStatusPrefKey);

    setState(() {
      temp2FaStatus = result ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = (context.read<LoginBloc>().state as LoginLoaded).userInfo;

    return BlocListener<TwoFAableBloc, TwoFAableState>(
      listener: (context, state) async {
        if (state is TwoFAableLoading) {
          LoadingScreen().show(
            context: context,
            text: 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }

        if (state is TwoFAableLoaded) {
          _snackBarService.showSnackbar(
            title: "Success",
            message: state.result,
          );

          await Future.delayed(const Duration(seconds: 2));

          Navigator.pop(context);
        }

        if (state is TwoFAableError) {
          await _dialogService.showCustomDialog(
            variant: DialogType.Generic,
            title: "Error",
            description: state.errorMessage.replaceAll('Exception:', ''),
          );
        }
      },
      child: Container(
        width: double.maxFinite,
        padding: getPadding(left: 20, right: 20, bottom: 65, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageView(
              url: widget.twoFAInfoModel.qrCodeUrl,
              height: getSize(400),
              width: getSize(400),
              onTap: () {},
            ),
            Padding(
              padding: getPadding(top: 10),
              child:
                  Text24SemiBold("${userInfo.firstname} ${userInfo.lastname}"),
            ),
            Padding(
              padding: getPadding(top: 8),
              child: Text16Medium("${userInfo.email}"),
            ),
            const VerticalSpace(30),
            userInfo.twoFa == 0 && temp2FaStatus == 0
                ? LargeButtonSecondaryColor(
                    title: "Enable 2FA Security",
                    onTap: () =>
                        _showBottomSheet(context, widget.twoFAInfoModel, true),
                  )
                : LargeButtonSecondaryColor(
                    title: "Disable 2FA Security",
                    onTap: () =>
                        _showBottomSheet(context, widget.twoFAInfoModel, false),
                  ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, TwoFAInfoModel twoFAInfoModel,
      bool isPerformEnable) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: OTPBottomSheetWidget(
            twoFAInfoModel: twoFAInfoModel,
            isPerformEnable: isPerformEnable,
          ),
        );
      },
    );
  }
}
