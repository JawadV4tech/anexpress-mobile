class SendMoneyRecipientModel {
  final int? totalReferralAmount;
  final SendMoneyModel? sendMoney;
  final List<SourceOfFund>? sourceFunds;
  final List<RecipientCity>? cities;
  final List<SendingPurpose>? sendingPurpose;

  SendMoneyRecipientModel({
    this.totalReferralAmount,
    this.sendMoney,
    this.sourceFunds,
    this.cities,
    this.sendingPurpose,
  });

  SendMoneyRecipientModel.fromJson(Map<String, dynamic> json)
      : totalReferralAmount = json['total_referral_amount'] as int?,
        sendMoney = (json['sendMoney'] as Map<String, dynamic>?) != null
            ? SendMoneyModel.fromJson(json['sendMoney'] as Map<String, dynamic>)
            : null,
        sourceFunds = (json['sourceFunds'] as List?)
            ?.map(
                (dynamic e) => SourceOfFund.fromJson(e as Map<String, dynamic>))
            .toList(),
        cities = (json['cities'] as List?)
            ?.map((dynamic e) =>
                RecipientCity.fromJson(e as Map<String, dynamic>))
            .toList(),
        sendingPurpose = (json['sendingPurpose'] as List?)
            ?.map((dynamic e) =>
                SendingPurpose.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'total_referral_amount': totalReferralAmount,
        'sendMoney': sendMoney?.toJson(),
        'sourceFunds': sourceFunds?.map((e) => e.toJson()).toList(),
        'cities': cities?.map((e) => e.toJson()).toList(),
        'sendingPurpose': sendingPurpose?.map((e) => e.toJson()).toList()
      };
}

class SendMoneyModel {
  final int? id;
  final int? userId;
  final int? sendCurrencyId;
  final int? receiveCurrencyId;
  final int? serviceId;
  final int? countryServiceId;
  final String? sendCurrRate;
  final String? sendCurr;
  final String? receiveCurr;
  final String? sendAmount;
  final String? fees;
  final String? payableAmount;
  final String? recipientGetAmount;
  final String? rate;
  final int? adminId;
  final String? adminReply;
  final int? invoice;
  final int? status;
  final int? paymentStatus;
  final String? paidAt;
  final String? promoCode;
  final double? discount;
  final double? referralDiscount;
  final String? fundSource;
  final String? purpose;
  final String? userInformation;
  final String? recipientName;
  final String? recipientEmail;
  final String? recipientContactNo;
  final String? recipientDob;
  final int? recipientCityId;
  final String? recipientAddress;
  final String? recipientGender;
  final String? recipientAccountName;
  final String? recipientIban;
  final int? recipientAccountNumber;
  final String? swiftNumber;
  final int? routingNumber;
  final int? sortingCode;
  final bool? isGovtEmployeeOutside;
  final String? govtEmployeeDetail;
  final String? relationshipWithReceipient;
  final String? paymentReference;
  final int? isFutureTrx;
  final String? receivedAt;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final double? totalPay;
  final double? totalBaseAmountPay;

  SendMoneyModel({
    this.id,
    this.userId,
    this.sendCurrencyId,
    this.receiveCurrencyId,
    this.serviceId,
    this.countryServiceId,
    this.sendCurrRate,
    this.sendCurr,
    this.receiveCurr,
    this.sendAmount,
    this.fees,
    this.payableAmount,
    this.recipientGetAmount,
    this.rate,
    this.adminId,
    this.adminReply,
    this.invoice,
    this.status,
    this.paymentStatus,
    this.paidAt,
    this.promoCode,
    this.discount,
    this.referralDiscount,
    this.fundSource,
    this.purpose,
    this.userInformation,
    this.recipientName,
    this.recipientEmail,
    this.recipientContactNo,
    this.recipientDob,
    this.recipientCityId,
    this.recipientAddress,
    this.recipientGender,
    this.recipientAccountName,
    this.recipientIban,
    this.recipientAccountNumber,
    this.swiftNumber,
    this.routingNumber,
    this.sortingCode,
    this.isGovtEmployeeOutside,
    this.govtEmployeeDetail,
    this.relationshipWithReceipient,
    this.paymentReference,
    this.isFutureTrx,
    this.receivedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.totalPay,
    this.totalBaseAmountPay,
  });

  SendMoneyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        sendCurrencyId = json['send_currency_id'] as int?,
        receiveCurrencyId = json['receive_currency_id'] as int?,
        serviceId = json['service_id'] as int?,
        countryServiceId = json['country_service_id'] as int?,
        sendCurrRate = json['send_curr_rate'] as String?,
        sendCurr = json['send_curr'] as String?,
        receiveCurr = json['receive_curr'] as String?,
        sendAmount = json['send_amount'] as String?,
        fees = json['fees'] as String?,
        payableAmount = json['payable_amount'] as String?,
        recipientGetAmount = json['recipient_get_amount'] as String?,
        rate = json['rate'] as String?,
        adminId = json['admin_id'] as int?,
        adminReply = json['admin_reply'] as String?,
        invoice = json['invoice'] as int?,
        status = json['status'] as int?,
        paymentStatus = json['payment_status'] as int?,
        paidAt = json['paid_at'] as String?,
        promoCode = json['promo_code'] as String?,
        discount = json['discount'] as double?,
        referralDiscount = json['referral_discount'] as double?,
        fundSource = json['fund_source'] as String?,
        purpose = json['purpose'] as String?,
        userInformation = json['user_information'] as String?,
        recipientName = json['recipient_name'] as String?,
        recipientEmail = json['recipient_email'] as String?,
        recipientContactNo = json['recipient_contact_no'] as String?,
        recipientDob = json['recipient_dob'] as String?,
        recipientCityId = json['recipient_city_id'] as int?,
        recipientAddress = json['recipient_address'] as String?,
        recipientGender = json['recipient_gender'] as String?,
        recipientAccountName = json['recipient_account_name'] as String?,
        recipientIban = json['recipient_iban'] as String?,
        recipientAccountNumber = json['recipient_account_number'] as int?,
        swiftNumber = json['swift_number'] as String?,
        routingNumber = json['routing_number'] as int?,
        sortingCode = json['sorting_code'] as int?,
        isGovtEmployeeOutside = json['is_govt_employee_outside'] as bool?,
        govtEmployeeDetail = json['govt_employee_detail'] as String?,
        relationshipWithReceipient =
            json['relationship_with_receipient'] as String?,
        paymentReference = json['payment_reference'] as String?,
        isFutureTrx = json['is_future_trx'] as int?,
        receivedAt = json['received_at'] as String?,
        deletedAt = json['deleted_at'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        totalPay = json['totalPay'].toDouble() as double?,
        totalBaseAmountPay = json['totalBaseAmountPay'].toDouble() as double?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'send_currency_id': sendCurrencyId,
        'receive_currency_id': receiveCurrencyId,
        'service_id': serviceId,
        'country_service_id': countryServiceId,
        'send_curr_rate': sendCurrRate,
        'send_curr': sendCurr,
        'receive_curr': receiveCurr,
        'send_amount': sendAmount,
        'fees': fees,
        'payable_amount': payableAmount,
        'recipient_get_amount': recipientGetAmount,
        'rate': rate,
        'admin_id': adminId,
        'admin_reply': adminReply,
        'invoice': invoice,
        'status': status,
        'payment_status': paymentStatus,
        'paid_at': paidAt,
        'promo_code': promoCode,
        'discount': discount,
        'referral_discount': referralDiscount,
        'fund_source': fundSource,
        'purpose': purpose,
        'user_information': userInformation,
        'recipient_name': recipientName,
        'recipient_email': recipientEmail,
        'recipient_contact_no': recipientContactNo,
        'recipient_dob': recipientDob,
        'recipient_city_id': recipientCityId,
        'recipient_address': recipientAddress,
        'recipient_gender': recipientGender,
        'recipient_account_name': recipientAccountName,
        'recipient_iban': recipientIban,
        'recipient_account_number': recipientAccountNumber,
        'swift_number': swiftNumber,
        'routing_number': routingNumber,
        'sorting_code': sortingCode,
        'is_govt_employee_outside': isGovtEmployeeOutside,
        'govt_employee_detail': govtEmployeeDetail,
        'relationship_with_receipient': relationshipWithReceipient,
        'payment_reference': paymentReference,
        'is_future_trx': isFutureTrx,
        'received_at': receivedAt,
        'deleted_at': deletedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'totalPay': totalPay,
        'totalBaseAmountPay': totalBaseAmountPay
      };
}

class SourceOfFund {
  final String? title;

  SourceOfFund({
    this.title,
  });

  SourceOfFund.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?;

  Map<String, dynamic> toJson() => {'title': title};
}

class RecipientCity {
  final int? id;
  final String? name;

  RecipientCity({
    this.id,
    this.name,
  });

  RecipientCity.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class SendingPurpose {
  final String? title;

  SendingPurpose({
    this.title,
  });

  SendingPurpose.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?;

  Map<String, dynamic> toJson() => {'title': title};
}
