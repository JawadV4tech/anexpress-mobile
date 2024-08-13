import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/countries_feature/bloc/countries_bloc.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeFeaturesList extends StatelessWidget {
  HomeFeaturesList({
    super.key,
  });

  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: getMargin(
          top: 150,
        ),
        padding: getPadding(left: 16, top: 23, right: 16, bottom: 23),
        child: Column(
          children: [
            HomeFeatureItemWidget(
              iconPath: LocalFiles.iconBulb,
              title: 'Great Rates',
              description:
                  'Great Rates, Low fees and Special new Customer Offer',
            ),
            HomeFeatureItemWidget(
              iconPath: LocalFiles.iconWallet,
              title: 'Track Your Transfer',
              description: 'Get status update from start to finish',
            ),
            HomeFeatureItemWidget(
              iconPath: LocalFiles.iconPrivate,
              title: 'Safe and Secure',
              description:
                  'Your information is always confidential and your funds are protected',
            ),
            const VerticalSpace(30),
            LargeButtonPrimaryColor(
              marginLeft: 0,
              marginRight: 0,
              title: "Send Money",
              onTap: () {
                // in Send Money View set 0 as First Tab Index
                // at 0 index is Selection of FROM TO country
                context
                    .read<SendMoneyBloc>()
                    .add(const UpdateTabEvent(activeTabIndex: 0));

                // make the Promo discount 0 if previously applied
                context.read<SendMoneyBloc>().add(
                      const UpdatePromoDiscountEvent(
                        discount: 0,
                      ),
                    );
                // make the Referral discount 0 if previously applied
                context.read<SendMoneyBloc>().add(
                      const UpdateReferralDiscountEvent(
                        discount: 0,
                      ),
                    );

                // call the CountriesGetEvent
                context.read<CountriesBloc>().add(const CountriesGetEvent());
                _navigationService.navigateTo(AppRoutes.sendMoneyScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeFeatureItemWidget extends StatelessWidget {
  const HomeFeatureItemWidget(
      {super.key,
      required this.iconPath,
      required this.description,
      required this.title});

  final String iconPath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        top: 3,
        bottom: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: iconPath,
            height: getSize(60),
            width: getSize(60),
            color: AppColors.gray60001,
          ),
          Padding(
            padding: getPadding(top: 10),
            child: Text24SemiBold(title),
          ),
          Padding(
            padding: getPadding(top: 10),
            child: Text14Medium(
              description,
            ),
          ),
        ],
      ),
    );
  }
}
