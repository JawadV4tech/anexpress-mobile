import 'package:equatable/equatable.dart';

class StoreCalculationModel extends Equatable {
  final String? invoice;
  final int? userId;
  final int? sendCurrencyId;
  final int? receiveCurrencyId;
  final int? serviceId;
  final int? countryServiceId;
  final String? sendCurrRate;
  final String? sendCurr;
  final String? receiveCurr;
  final double? rate;
  final double? sendAmount;
  final double? fees;
  final double? payableAmount;
  final double? recipientGetAmount;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final double? totalPay;
  final double? totalBaseAmountPay;

  const StoreCalculationModel({
    this.invoice,
    this.userId,
    this.sendCurrencyId,
    this.receiveCurrencyId,
    this.serviceId,
    this.countryServiceId,
    this.sendCurrRate,
    this.sendCurr,
    this.receiveCurr,
    this.rate,
    this.sendAmount,
    this.fees,
    this.payableAmount,
    this.recipientGetAmount,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.totalPay,
    this.totalBaseAmountPay,
  });

  StoreCalculationModel.fromJson(Map<String, dynamic> json)
      : invoice = json['invoice'] as String?,
        userId = json['user_id'] as int?,
        sendCurrencyId = json['send_currency_id'] as int?,
        receiveCurrencyId = json['receive_currency_id'] as int?,
        serviceId = json['service_id'] as int?,
        countryServiceId = json['country_service_id'] as int?,
        sendCurrRate = json['send_curr_rate'] as String?,
        sendCurr = json['send_curr'] as String?,
        receiveCurr = json['receive_curr'] as String?,
        rate = json['rate'].toDouble() as double?,
        sendAmount = json['send_amount'].toDouble() as double?,
        fees = json['fees'].toDouble() as double?,
        payableAmount = json['payable_amount'].toDouble() as double?,
        recipientGetAmount = json['recipient_get_amount'].toDouble() as double?,
        updatedAt = json['updated_at'] as String?,
        createdAt = json['created_at'] as String?,
        id = json['id'] as int?,
        totalPay = json['totalPay'].toDouble() as double?,
        totalBaseAmountPay = json['totalBaseAmountPay'].toDouble() as double?;

  Map<String, dynamic> toJson() => {
        'invoice': invoice,
        'user_id': userId,
        'send_currency_id': sendCurrencyId,
        'receive_currency_id': receiveCurrencyId,
        'service_id': serviceId,
        'country_service_id': countryServiceId,
        'send_curr_rate': sendCurrRate,
        'send_curr': sendCurr,
        'receive_curr': receiveCurr,
        'rate': rate,
        'send_amount': sendAmount,
        'fees': fees,
        'payable_amount': payableAmount,
        'recipient_get_amount': recipientGetAmount,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'id': id,
        'totalPay': totalPay,
        'totalBaseAmountPay': totalBaseAmountPay
      };

  @override
  List<Object?> get props {
    return [
      invoice,
      userId,
      sendCurrencyId,
      receiveCurrencyId,
      serviceId,
      countryServiceId,
      sendCurrRate,
      sendCurr,
      receiveCurr,
      rate,
      sendAmount,
      fees,
      payableAmount,
      recipientGetAmount,
      updatedAt,
      createdAt,
      id,
      totalPay,
      totalBaseAmountPay,
    ];
  }

  @override
  String toString() {
    return 'StoreCalculationModel(invoice: $invoice, userId: $userId, sendCurrencyId: $sendCurrencyId, receiveCurrencyId: $receiveCurrencyId, serviceId: $serviceId, countryServiceId: $countryServiceId, sendCurrRate: $sendCurrRate, sendCurr: $sendCurr, receiveCurr: $receiveCurr, rate: $rate, sendAmount: $sendAmount, fees: $fees, payableAmount: $payableAmount, recipientGetAmount: $recipientGetAmount, updatedAt: $updatedAt, createdAt: $createdAt, id: $id, totalPay: $totalPay, totalBaseAmountPay: $totalBaseAmountPay)';
  }
}
