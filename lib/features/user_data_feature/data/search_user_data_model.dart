import 'package:equatable/equatable.dart';

class SearchUserDataModel extends Equatable {
  final int? id;
  final String? recipientName;
  final String? recipientContactNo;
  final String? recipientEmail;
  final String? recipientDob;
  final String? recipientGender;
  final int? recipientCityId;
  final String? recipientAddress;
  final String? recipientIban;
  final String? recipientAccountNumber;
  final String? routingNumber;
  final String? swiftNumber;
  final String? sortingCode;

  const SearchUserDataModel({
    this.id,
    this.recipientName,
    this.recipientContactNo,
    this.recipientEmail,
    this.recipientDob,
    this.recipientGender,
    this.recipientCityId,
    this.recipientAddress,
    this.recipientIban,
    this.recipientAccountNumber,
    this.routingNumber,
    this.swiftNumber,
    this.sortingCode,
  });

  SearchUserDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        recipientName = json['recipient_name'] as String?,
        recipientContactNo = json['recipient_contact_no'] as String?,
        recipientEmail = json['recipient_email'] as String?,
        recipientDob = json['recipient_dob'] as String?,
        recipientGender = json['recipient_gender'] as String?,
        recipientCityId = json['recipient_city_id'] as int?,
        recipientAddress = json['recipient_address'] as String?,
        recipientIban = json['recipient_iban'] as String?,
        recipientAccountNumber = json['recipient_account_number'] as String?,
        routingNumber = json['routing_number'] as String?,
        swiftNumber = json['swift_number'] as String?,
        sortingCode = json['sorting_code'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipient_name': recipientName,
        'recipient_contact_no': recipientContactNo,
        'recipient_email': recipientEmail,
        'recipient_dob': recipientDob,
        'recipient_gender': recipientGender,
        'recipient_city_id': recipientCityId,
        'recipient_address': recipientAddress,
        'recipient_iban': recipientIban,
        'recipient_account_number': recipientAccountNumber,
        'routing_number': routingNumber,
        'swift_number': swiftNumber,
        'sorting_code': sortingCode
      };

  @override
  List<Object?> get props {
    return [
      id,
      recipientName,
      recipientContactNo,
      recipientEmail,
      recipientDob,
      recipientGender,
      recipientCityId,
      recipientAddress,
      recipientIban,
      recipientAccountNumber,
      routingNumber,
      swiftNumber,
      sortingCode,
    ];
  }
}
