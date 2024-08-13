import 'package:equatable/equatable.dart';

class PaymentCardResponseModel extends Equatable {
  final String? totalAmount;
  final String? cn;
  final String? email;
  final String? dob;
  final String? pspid;
  final String? shasign;
  final String? currency;
  final String? transaction;
  final String? url;
  final String? testUrl;
  final String? liveUrl;
  final String? view;

  const PaymentCardResponseModel({
    this.totalAmount,
    this.cn,
    this.email,
    this.dob,
    this.pspid,
    this.shasign,
    this.currency,
    this.transaction,
    this.url,
    this.testUrl,
    this.liveUrl,
    this.view,
  });

  PaymentCardResponseModel.fromJson(Map<String, dynamic> json)
      : totalAmount = json['total_amount'] as String?,
        cn = json['cn'] as String?,
        email = json['email'] as String?,
        dob = json['dob'] as String?,
        pspid = json['pspid'] as String?,
        shasign = json['shasign'] as String?,
        currency = json['currency'] as String?,
        transaction = json['transaction'] as String?,
        url = json['url'] as String?,
        testUrl = json['test_url'] as String?,
        liveUrl = json['live_url'] as String?,
        view = json['view'] as String?;

  Map<String, dynamic> toJson() => {
        'total_amount': totalAmount,
        'cn': cn,
        'email': email,
        'dob': dob,
        'pspid': pspid,
        'shasign': shasign,
        'currency': currency,
        'transaction': transaction,
        'url': url,
        'test_url': testUrl,
        'live_url': liveUrl,
        'view': view
      };

  @override
  List<Object?> get props {
    return [
      totalAmount,
      cn,
      email,
      dob,
      pspid,
      shasign,
      currency,
      transaction,
      url,
      testUrl,
      liveUrl,
      view,
    ];
  }

  @override
  String toString() {
    return 'PaymentCardResponseModel(totalAmount: $totalAmount, cn: $cn, email: $email, dob: $dob, pspid: $pspid, shasign: $shasign, currency: $currency, transaction: $transaction, url: $url, testUrl: $testUrl, liveUrl: $liveUrl, view: $view)';
  }
}
