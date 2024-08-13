class DocumentsStatusModel {
  final int? identityVerify;
  final int? addressVerify;

  DocumentsStatusModel({
    this.identityVerify,
    this.addressVerify,
  });

  DocumentsStatusModel.fromJson(Map<String, dynamic> json)
      : identityVerify = json['identity_verify'] as int?,
        addressVerify = json['address_verify'] as int?;

  Map<String, dynamic> toJson() => {
        'identity_verify': identityVerify,
        'address_verify': addressVerify,
      };
}
