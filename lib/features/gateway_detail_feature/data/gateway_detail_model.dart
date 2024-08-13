import 'package:equatable/equatable.dart';

class GatewayDetailModel extends Equatable {
  final String? gatewayImage;
  final String? amount;
  final String? charge;
  final String? gatewayCurrency;
  final String? payable;
  final String? conversionRate;
  final String? inCurrency;
  final bool? isCrypto;
  final String? conversionWith;
  final String? track;
  final String? paymentUrl;

  const GatewayDetailModel({
    this.gatewayImage,
    this.amount,
    this.charge,
    this.gatewayCurrency,
    this.payable,
    this.conversionRate,
    this.inCurrency,
    this.isCrypto,
    this.conversionWith,
    this.track,
    this.paymentUrl,
  });

  GatewayDetailModel.fromJson(Map<String, dynamic> json)
      : gatewayImage = json['gateway_image'] as String?,
        amount = json['amount'] as String?,
        charge = json['charge'] as String?,
        gatewayCurrency = json['gateway_currency'] as String?,
        payable = json['payable'] as String?,
        conversionRate = json['conversion_rate'] as String?,
        inCurrency = json['in'] as String?,
        isCrypto = json['isCrypto'] as bool?,
        conversionWith = json['conversion_with'] as String?,
        track = json['track'] as String?,
        paymentUrl = json['payment_url'] as String?;

  Map<String, dynamic> toJson() => {
        'gateway_image': gatewayImage,
        'amount': amount,
        'charge': charge,
        'gateway_currency': gatewayCurrency,
        'payable': payable,
        'conversion_rate': conversionRate,
        'in': inCurrency,
        'isCrypto': isCrypto,
        'conversion_with': conversionWith,
        'track': track,
        'payment_url': paymentUrl
      };

  @override
  List<Object?> get props {
    return [
      gatewayImage,
      amount,
      charge,
      gatewayCurrency,
      payable,
      conversionRate,
      inCurrency,
      isCrypto,
      conversionWith,
      track,
      paymentUrl,
    ];
  }
}
