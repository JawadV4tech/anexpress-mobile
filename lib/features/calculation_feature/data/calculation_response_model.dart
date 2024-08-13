import 'package:equatable/equatable.dart';

class CalculationInfoModel extends Equatable {
  final SendCountry? sendCountry;
  final ReceiveCountry? receiveCountry;
  final ReceiveCountryFacilities? receiveCountryFacilities;
  final String? rate;
  final String? sendCurrency;
  final String? receiveCurrency;
  final double? sendAmount;
  final double? fees;
  final double? totalPayable;
  final double? recipientGet;

  const CalculationInfoModel({
    this.sendCountry,
    this.receiveCountry,
    this.receiveCountryFacilities,
    this.rate,
    this.sendCurrency,
    this.receiveCurrency,
    this.sendAmount,
    this.fees,
    this.totalPayable,
    this.recipientGet,
  });

  CalculationInfoModel.fromJson(Map<String, dynamic> json)
      : sendCountry = (json['sendCountry'] as Map<String, dynamic>?) != null
            ? SendCountry.fromJson(json['sendCountry'] as Map<String, dynamic>)
            : null,
        receiveCountry =
            (json['receiveCountry'] as Map<String, dynamic>?) != null
                ? ReceiveCountry.fromJson(
                    json['receiveCountry'] as Map<String, dynamic>)
                : null,
        receiveCountryFacilities =
            (json['receiveCountryFacilities'] as Map<String, dynamic>?) != null
                ? ReceiveCountryFacilities.fromJson(
                    json['receiveCountryFacilities'] as Map<String, dynamic>)
                : null,
        rate = json['rate'] as String?,
        sendCurrency = json['send_currency'] as String?,
        receiveCurrency = json['receive_currency'] as String?,
        sendAmount = json['send_amount'].toDouble() as double?,
        fees = json['fees'].toDouble() as double?,
        totalPayable = json['total_payable'].toDouble() as double?,
        recipientGet = json['recipient_get'].toDouble() as double?;

  Map<String, dynamic> toJson() => {
        'sendCountry': sendCountry?.toJson(),
        'receiveCountry': receiveCountry?.toJson(),
        'receiveCountryFacilities': receiveCountryFacilities?.toJson(),
        'rate': rate,
        'send_currency': sendCurrency,
        'receive_currency': receiveCurrency,
        'send_amount': sendAmount,
        'fees': fees,
        'total_payable': totalPayable,
        'recipient_get': recipientGet
      };

  @override
  List<Object?> get props {
    return [
      sendCountry,
      receiveCountry,
      receiveCountryFacilities,
      rate,
      sendCurrency,
      receiveCurrency,
      sendAmount,
      fees,
      totalPayable,
      recipientGet,
    ];
  }
}

class SendCountry extends Equatable {
  final int? id;
  final String? name;
  final String? slug;
  final String? code;
  final String? minimumAmount;
  final String? rate;
  final List<Facilities>? facilities;
  final String? image;
  final String? flag;

  const SendCountry({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.minimumAmount,
    this.rate,
    this.facilities,
    this.image,
    this.flag,
  });

  SendCountry.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        code = json['code'] as String?,
        minimumAmount = json['minimum_amount'] as String?,
        rate = json['rate'] as String?,
        facilities = (json['facilities'] as List?)
            ?.map((dynamic e) => Facilities.fromJson(e as Map<String, dynamic>))
            .toList(),
        image = json['image'] as String?,
        flag = json['flag'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'code': code,
        'minimum_amount': minimumAmount,
        'rate': rate,
        'facilities': facilities?.map((e) => e.toJson()).toList(),
        'image': image,
        'flag': flag
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      code,
      minimumAmount,
      rate,
      facilities,
      image,
      flag,
    ];
  }
}

class Facilities extends Equatable {
  final int? id;
  final String? name;

  const Facilities({
    this.id,
    this.name,
  });

  Facilities.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}

class ReceiveCountry extends Equatable {
  final int? id;
  final String? name;
  final String? slug;
  final String? code;
  final String? minimumAmount;
  final String? rate;
  final List<Facilities>? facilities;
  final String? image;
  final String? flag;

  const ReceiveCountry({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.minimumAmount,
    this.rate,
    this.facilities,
    this.image,
    this.flag,
  });

  ReceiveCountry.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        code = json['code'] as String?,
        minimumAmount = json['minimum_amount'] as String?,
        rate = json['rate'] as String?,
        facilities = (json['facilities'] as List?)
            ?.map((dynamic e) => Facilities.fromJson(e as Map<String, dynamic>))
            .toList(),
        image = json['image'] as String?,
        flag = json['flag'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'code': code,
        'minimum_amount': minimumAmount,
        'rate': rate,
        'facilities': facilities?.map((e) => e.toJson()).toList(),
        'image': image,
        'flag': flag
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      code,
      minimumAmount,
      rate,
      facilities,
      image,
      flag,
    ];
  }
}

class ReceiveCountryFacilities extends Equatable {
  final int? id;
  final String? name;

  const ReceiveCountryFacilities({
    this.id,
    this.name,
  });

  ReceiveCountryFacilities.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
