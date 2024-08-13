import 'package:anexpress/features/privacy_policy_screen/data/privacy_terms_conditions_model.dart';
import 'package:anexpress/features/privacy_policy_screen/view/components/html_description_render.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({
    super.key,
    required this.title,
    required this.privacyPolicy,
  });

  final String title;
  final PrivacyPolicy privacyPolicy;

  @override
  Widget build(BuildContext context) {
    return HtmlDescriptionRender(
      description: privacyPolicy.description?.description ?? "",
    );
  }
}
