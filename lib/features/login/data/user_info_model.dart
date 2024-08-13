import 'package:equatable/equatable.dart';

class UserInfoModel extends Equatable {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? username;
  final dynamic referralId;
  final dynamic languageId;
  final int? userTypeId;
  final String? email;
  final dynamic phone;
  final dynamic dob;
  final int? balance;
  final dynamic image;
  final int? countryId;
  final dynamic cityId;
  final dynamic postalCode;
  final dynamic address;
  final dynamic nationality;
  final dynamic placeOfBirth;
  final dynamic oldCustomerId;
  final dynamic relationshipWithReceipient;
  final dynamic occupation;
  final dynamic expectedAmountPerMonth;
  final dynamic provider;
  final dynamic providerId;
  final int? status;
  final int? identityVerify;
  final int? addressVerify;
  final int? twoFa;
  final int? twoFaVerify;
  final dynamic twoFaCode;
  final dynamic twoFaCodeSmsEmail;
  final int? emailVerification;
  final int? smsVerification;
  final dynamic verifyCode;
  final dynamic sentAt;
  final String? lastLogin;
  final String? lastLoginIp;
  final int? consentForMarketing;
  final int? termsConditions;
  final dynamic emailVerifiedAt;
  final String? apiToken;
  final String? createdAt;
  final String? updatedAt;
  final String? fullname;
  final dynamic mobile;
  final String? profileName;
  final String? photo;

  const UserInfoModel({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.referralId,
    this.languageId,
    this.userTypeId,
    this.email,
    this.phone,
    this.dob,
    this.balance,
    this.image,
    this.countryId,
    this.cityId,
    this.postalCode,
    this.address,
    this.nationality,
    this.placeOfBirth,
    this.oldCustomerId,
    this.relationshipWithReceipient,
    this.occupation,
    this.expectedAmountPerMonth,
    this.provider,
    this.providerId,
    this.status,
    this.identityVerify,
    this.addressVerify,
    this.twoFa,
    this.twoFaVerify,
    this.twoFaCode,
    this.twoFaCodeSmsEmail,
    this.emailVerification,
    this.smsVerification,
    this.verifyCode,
    this.sentAt,
    this.lastLogin,
    this.lastLoginIp,
    this.consentForMarketing,
    this.termsConditions,
    this.emailVerifiedAt,
    this.apiToken,
    this.createdAt,
    this.updatedAt,
    this.fullname,
    this.mobile,
    this.profileName,
    this.photo,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        username = json['username'] as String?,
        referralId = json['referral_id'],
        languageId = json['language_id'],
        userTypeId = json['user_type_id'] as int?,
        email = json['email'] as String?,
        phone = json['phone'],
        dob = json['dob'],
        balance = json['balance'] as int?,
        image = json['image'],
        countryId = json['country_id'] as int?,
        cityId = json['city_id'],
        postalCode = json['postal_code'],
        address = json['address'],
        nationality = json['nationality'],
        placeOfBirth = json['place_of_birth'],
        oldCustomerId = json['old_customer_id'],
        relationshipWithReceipient = json['relationship_with_receipient'],
        occupation = json['occupation'],
        expectedAmountPerMonth = json['expected_amount_per_month'],
        provider = json['provider'],
        providerId = json['provider_id'],
        status = json['status'] as int?,
        identityVerify = json['identity_verify'] as int?,
        addressVerify = json['address_verify'] as int?,
        twoFa = json['two_fa'] as int?,
        twoFaVerify = json['two_fa_verify'] as int?,
        twoFaCode = json['two_fa_code'],
        twoFaCodeSmsEmail = json['two_fa_code_sms_email'],
        emailVerification = json['email_verification'] as int?,
        smsVerification = json['sms_verification'] as int?,
        verifyCode = json['verify_code'],
        sentAt = json['sent_at'],
        lastLogin = json['last_login'] as String?,
        lastLoginIp = json['last_login_ip'] as String?,
        consentForMarketing = json['consent_for_marketing'] as int?,
        termsConditions = json['terms_conditions'] as int?,
        emailVerifiedAt = json['email_verified_at'],
        apiToken = json['api_token'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        fullname = json['fullname'] as String?,
        mobile = json['mobile'],
        profileName = json['profileName'] as String?,
        photo = json['photo'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'referral_id': referralId,
        'language_id': languageId,
        'user_type_id': userTypeId,
        'email': email,
        'phone': phone,
        'dob': dob,
        'balance': balance,
        'image': image,
        'country_id': countryId,
        'city_id': cityId,
        'postal_code': postalCode,
        'address': address,
        'nationality': nationality,
        'place_of_birth': placeOfBirth,
        'old_customer_id': oldCustomerId,
        'relationship_with_receipient': relationshipWithReceipient,
        'occupation': occupation,
        'expected_amount_per_month': expectedAmountPerMonth,
        'provider': provider,
        'provider_id': providerId,
        'status': status,
        'identity_verify': identityVerify,
        'address_verify': addressVerify,
        'two_fa': twoFa,
        'two_fa_verify': twoFaVerify,
        'two_fa_code': twoFaCode,
        'two_fa_code_sms_email': twoFaCodeSmsEmail,
        'email_verification': emailVerification,
        'sms_verification': smsVerification,
        'verify_code': verifyCode,
        'sent_at': sentAt,
        'last_login': lastLogin,
        'last_login_ip': lastLoginIp,
        'consent_for_marketing': consentForMarketing,
        'terms_conditions': termsConditions,
        'email_verified_at': emailVerifiedAt,
        'api_token': apiToken,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'fullname': fullname,
        'mobile': mobile,
        'profileName': profileName,
        'photo': photo
      };

  @override
  List<Object?> get props {
    return [
      id,
      firstname,
      lastname,
      username,
      referralId,
      languageId,
      userTypeId,
      email,
      phone,
      dob,
      balance,
      image,
      countryId,
      cityId,
      postalCode,
      address,
      nationality,
      placeOfBirth,
      oldCustomerId,
      relationshipWithReceipient,
      occupation,
      expectedAmountPerMonth,
      provider,
      providerId,
      status,
      identityVerify,
      addressVerify,
      twoFa,
      twoFaVerify,
      twoFaCode,
      twoFaCodeSmsEmail,
      emailVerification,
      smsVerification,
      verifyCode,
      sentAt,
      lastLogin,
      lastLoginIp,
      consentForMarketing,
      termsConditions,
      emailVerifiedAt,
      apiToken,
      createdAt,
      updatedAt,
      fullname,
      mobile,
      profileName,
      photo,
    ];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname, lastname: $lastname, username: $username, referralId: $referralId, languageId: $languageId, userTypeId: $userTypeId, email: $email, phone: $phone, dob: $dob, balance: $balance, image: $image, countryId: $countryId, cityId: $cityId, postalCode: $postalCode, address: $address, nationality: $nationality, placeOfBirth: $placeOfBirth, oldCustomerId: $oldCustomerId, relationshipWithReceipient: $relationshipWithReceipient, occupation: $occupation, expectedAmountPerMonth: $expectedAmountPerMonth, provider: $provider, providerId: $providerId, status: $status, identityVerify: $identityVerify, addressVerify: $addressVerify, twoFa: $twoFa, twoFaVerify: $twoFaVerify, twoFaCode: $twoFaCode, twoFaCodeSmsEmail: $twoFaCodeSmsEmail, emailVerification: $emailVerification, smsVerification: $smsVerification, verifyCode: $verifyCode, sentAt: $sentAt, lastLogin: $lastLogin, lastLoginIp: $lastLoginIp, consentForMarketing: $consentForMarketing, termsConditions: $termsConditions, emailVerifiedAt: $emailVerifiedAt, apiToken: $apiToken, createdAt: $createdAt, updatedAt: $updatedAt, fullname: $fullname, mobile: $mobile, profileName: $profileName, photo: $photo)';
  }
}
