import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/privacy_policy_screen/bloc/privacy_bloc.dart';
import 'package:anexpress/features/privacy_policy_screen/view/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreeTermsText extends StatelessWidget {
  const AgreeTermsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text16SemiBold(Loc.alized.msg_by_continuing_you),
            const HorizontalSpace(3),
            InkWell(
              onTap: () {
                context.read<PrivacyBloc>().add(const PrivacyGetEvent());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
              child: const Text16SemiBoldOrangeUnderLined("Terms and"),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            context.read<PrivacyBloc>().add(const PrivacyGetEvent());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicyScreen(),
              ),
            );
          },
          child: Padding(
            padding: getPadding(top: 11),
            child: const Text16SemiBoldOrangeUnderLined("Privacy Policy"),
          ),
        ),
        Padding(
          padding: getPadding(top: 20, bottom: 20),
          child: InkWell(
            onTap: () {
              _launchUrl("https://v4tech.co.uk/");
            },
            child: const Row(
              children: [
                Text16SemiBold("Powered By "),
                HorizontalSpace(3),
                Text16SemiBoldOrangeUnderLined("V4tech"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String urlToShare) async {
    final Uri url = Uri.parse(urlToShare);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
