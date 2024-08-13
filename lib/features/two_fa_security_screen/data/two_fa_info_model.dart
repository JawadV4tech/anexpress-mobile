import 'package:equatable/equatable.dart';

class TwoFAInfoModel extends Equatable {
  final String? secret;
  final String? qrCodeUrl;
  final dynamic previousCode;
  final String? previousQR;

  const TwoFAInfoModel({
    this.secret,
    this.qrCodeUrl,
    this.previousCode,
    this.previousQR,
  });

  TwoFAInfoModel.fromJson(Map<String, dynamic> json)
      : secret = json['secret'] as String?,
        qrCodeUrl = json['qrCodeUrl'] as String?,
        previousCode = json['previousCode'],
        previousQR = json['previousQR'] as String?;

  Map<String, dynamic> toJson() => {
        'secret': secret,
        'qrCodeUrl': qrCodeUrl,
        'previousCode': previousCode,
        'previousQR': previousQR
      };

  @override
  List<Object?> get props => [secret, qrCodeUrl, previousCode, previousQR];
}
