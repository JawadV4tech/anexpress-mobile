import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/account_delete/account_delete_request_view.dart';
import 'package:anexpress/features/contact_us/view/contact_us_view.dart';
import 'package:anexpress/features/countries_feature/bloc/countries_bloc.dart';
import 'package:anexpress/features/home_sidebar_menu_screen/components/drawer_header_widget.dart';
import 'package:anexpress/features/home_sidebar_menu_screen/components/side_drawer_list_tile.dart';
import 'package:anexpress/features/logout_feature/bloc/logout_bloc.dart';
import 'package:anexpress/features/privacy_policy_screen/bloc/privacy_bloc.dart';
import 'package:anexpress/features/privacy_policy_screen/view/privacy_policy_screen.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:anexpress/features/two_fa_security_screen/bloc/two_fa_bloc.dart';
import 'package:anexpress/features/two_fa_security_screen/view/two_fa_security_screen.dart';
import 'package:anexpress/features/upload_documents/upload_documents_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeSidebarMenuScreen extends StatelessWidget {
  HomeSidebarMenuScreen({super.key});

  final _navigationService = locator<NavigationService>();
  // final DialogService _dialogService = locator<DialogService>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: size.height,
        //width: MediaQuery.of(context).size.width * 0.30,
        color: Theme.of(context).canvasColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DrawerHeaderWidget(),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: getPadding(
                      left: 20,
                      top: 0,
                      right: 20,
                      bottom: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          height: getVerticalSize(
                            60,
                          ),
                          width: getHorizontalSize(252),
                          text: "Contact Us",
                          margin: getMargin(top: 20),
                          variant: ButtonVariant.FillOrange7006c,
                          shape: ButtonShape.RoundedBorder10,
                          padding: ButtonPadding.PaddingAll17,
                          fontStyle: ButtonFontStyle.SemiBold20,
                          alignment: Alignment.center,
                          onTap: () {
                            Navigator.of(context).pop();

                            _navigationService
                                .navigateToView(const ContactUsView());

                            // _dialogService.showCustomDialog(
                            //   variant: DialogType.Generic,
                            //   title: "Success",
                            //   description: "This is Test Dialogue",
                            // );
                          },
                        ),
                        SideDrawerListTile(
                          svgPath: LocalFiles.iconSendMoney,
                          title: "Send Money",
                          onTap: () {
                            // close the side menu
                            Navigator.of(context).pop();
                            // in Send Money View set 0 as First Tab Index
                            // at 0 index is Selection of FROM TO country
                            context
                                .read<SendMoneyBloc>()
                                .add(const UpdateTabEvent(activeTabIndex: 0));

                            // call the CountriesGetEvent
                            context
                                .read<CountriesBloc>()
                                .add(const CountriesGetEvent());
                            _navigationService
                                .navigateTo(AppRoutes.sendMoneyScreen);
                          },
                        ),
                        SideDrawerListTile(
                          svgPath: LocalFiles.icon2Fa,
                          title: "2FA Security",
                          onTap: () {
                            context
                                .read<TwoFABloc>()
                                .add(const TwoFAGetEvent());

                            Navigator.of(context).pop();

                            _navigationService
                                .navigateToView(const TwoFASecurityScreen());
                          },
                        ),
                        SideDrawerListTile(
                          svgPath: LocalFiles.imgFile,
                          title: "Upload Documents",
                          onTap: () {
                            Navigator.of(context).pop();
                            _navigationService
                                .navigateToView(const UploadDocumentsView());
                          },
                        ),
                        SideDrawerListTile(
                          svgPath: LocalFiles.imgInfo,
                          title: "Privacy",
                          onTap: () {
                            Navigator.of(context).pop();

                            _navigationService
                                .navigateToView(const PrivacyPolicyScreen());

                            context
                                .read<PrivacyBloc>()
                                .add(const PrivacyGetEvent());
                          },
                        ),
                        SideDrawerListTile(
                          svgPath: LocalFiles.imgQrcode,
                          title: "Logout",
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<LogoutBloc>()
                                .add(const PerformUserLogout());
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: InkWell(
                            onTap: () {
                              _showConfirmationDialog(context);
                            },
                            child: Text(
                              "Delete Account",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtMontserratRomanRegular14
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 48.0),
                            child: Text(
                              "App Version: 1.0",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtMontserratRomanRegular14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be restored.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                _navigationService
                    .navigateToView(const AccountDeleteRequestView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change button color to red
              ),
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
