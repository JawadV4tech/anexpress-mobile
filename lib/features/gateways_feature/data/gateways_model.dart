import 'package:equatable/equatable.dart';

class GatewaysModel extends Equatable {
  final String? message;
  final List<GateWaysData>? data;
  final String? url;

  const GatewaysModel({
    this.message,
    this.data,
    this.url,
  });

  GatewaysModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map(
                (dynamic e) => GateWaysData.fromJson(e as Map<String, dynamic>))
            .toList(),
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
        'url': url
      };

  @override
  List<Object?> get props => [message, data, url];
}

class GateWaysData extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? description;
  final String? image;
  final String? currency;
  final String? minAmount;
  final String? maxAmount;
  final String? percentageCharge;
  final String? fixedCharge;

  const GateWaysData({
    this.id,
    this.code,
    this.name,
    this.description,
    this.image,
    this.currency,
    this.minAmount,
    this.maxAmount,
    this.percentageCharge,
    this.fixedCharge,
  });

  GateWaysData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        code = json['code'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        image = json['image'] as String?,
        currency = json['currency'] as String?,
        minAmount = json['min_amount'] as String?,
        maxAmount = json['max_amount'] as String?,
        percentageCharge = json['percentage_charge'] as String?,
        fixedCharge = json['fixed_charge'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'description': description,
        'image': image,
        'currency': currency,
        'min_amount': minAmount,
        'max_amount': maxAmount,
        'percentage_charge': percentageCharge,
        'fixed_charge': fixedCharge
      };

  @override
  List<Object?> get props {
    return [
      id,
      code,
      name,
      description,
      image,
      currency,
      minAmount,
      maxAmount,
      percentageCharge,
      fixedCharge,
    ];
  }
}
