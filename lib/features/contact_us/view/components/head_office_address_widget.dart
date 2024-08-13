import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/contact_us/view/components/large_yellow_heading.dart';
import 'package:flutter/material.dart';

class HeadOfficeAddressWidget extends StatelessWidget {
  const HeadOfficeAddressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          CustomImageView(
            svgPath: LocalFiles.bills,
            height: getSize(20),
            width: getSize(20),
            alignment: Alignment.bottomLeft,
          ),
          const LargeYellowHeading(
            headingText: 'Head Office',
            fontSize: 16,
          ),
          const Column(
            children: [
              Text(
                "Address: ${"state.storeInfo.address1"} ${"state.storeInfo.country"}",
                textAlign: TextAlign.center,
              ),
              Text(
                "Email: ${"state.storeInfo.emai"}",
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
