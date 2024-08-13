import 'package:anexpress/features/privacy_policy_screen/data/privacy_terms_conditions_model.dart';
import 'package:anexpress/features/privacy_policy_screen/view/components/html_description_render.dart';
import 'package:flutter/material.dart';

class TermsServicesContent extends StatelessWidget {
  const TermsServicesContent({
    super.key,
    required this.title,
    required this.termsServices,
  });

  final String title;
  final TermsConditions termsServices;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HtmlDescriptionRender(
            description: termsServices.description?.description ?? "",
          )
        ],
      ),
    );
  }
}
