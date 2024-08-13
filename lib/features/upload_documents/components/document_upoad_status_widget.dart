import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/upload_documents/address_document_upload.dart';
import 'package:anexpress/features/upload_documents/components/upload_doc_tile.dart';
import 'package:anexpress/features/upload_documents/driving_license_document_upload.dart';
import 'package:anexpress/features/upload_documents/identity_document_upload.dart';
import 'package:anexpress/features/upload_documents/passport_document_upload.dart';
import 'package:anexpress/widgets/text_18_semibold_theme.dart';
import 'package:flutter/material.dart';

class DocumentUploadStatusWidget extends StatelessWidget {
  const DocumentUploadStatusWidget({
    super.key,
    required this.uploadStatus,
    required this.isAddressUpload,
  });

  final int uploadStatus;

  final bool isAddressUpload;

  @override
  Widget build(BuildContext context) {
// 0 = Not applied yet (option to upload available)
// 1 = Uploaded , verification in pending state (option to upload NOT available)
// 2 = approved (Your documents has been approved) (option to upload NOT available)
// 3 = Uploaded rejected, upload again (option to upload  available)
// "address_verify": 1 is for address
// and "identity_verify": 1, is for National ID, Passport and Driving License

    return Padding(
      padding: getPadding(left: 10, top: 30, right: 10, bottom: 30),
      child: Column(
        children: [
          if (isAddressUpload)
            UploadDocTile(
              title: "Address Proof",
              iconPath: LocalFiles.iconLocation,
              uploadStatus: uploadStatus,
              onTapUpload: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressDocumentUpload(),
                  ),
                );
              },
            ),
          if (!isAddressUpload)
            Column(
              children: [
                UploadDocTile(
                  title: "National ID",
                  iconPath: LocalFiles.idCard2,
                  uploadStatus: uploadStatus,
                  onTapUpload: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const IdentityDocumentUpload(title: "National ID"),
                      ),
                    );
                  },
                ),
                UploadDocTile(
                  title: "Passport",
                  iconPath: LocalFiles.passport,
                  uploadStatus: uploadStatus,
                  onTapUpload: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PassportDocumentUpload(
                          title: "Passport",
                        ),
                      ),
                    );
                  },
                ),
                UploadDocTile(
                  title: "Driving License",
                  iconPath: LocalFiles.userCheck,
                  uploadStatus: uploadStatus,
                  onTapUpload: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DrivingDocumentUpload(
                          title: "Driving License",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          Container(
            padding: getPadding(left: 10, top: 4, right: 10, bottom: 4),
            decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              children: [
                if (uploadStatus == 1)
                  const Text18SemiBoldTheme(
                      "Document Submitted, Verification in Progress"),
                if (uploadStatus == 2)
                  const Text18SemiBoldTheme("Your document has been approved"),
                if (uploadStatus == 3)
                  const Text18SemiBoldTheme(
                      "Document not approved, Submit again"),
              ],
            ),
          ),
          Padding(
            padding: getPadding(top: 30),
            child: DividerWidget(
              indent: getHorizontalSize(0),
              endIndent: getHorizontalSize(0),
            ),
          ),
        ],
      ),
    );
  }
}
