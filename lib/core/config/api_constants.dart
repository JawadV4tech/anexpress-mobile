const String apiBaseUrl = "**********";

const String userRegisterApi = '$apiBaseUrl/****';
const String userLoginApi = '$apiBaseUrl/****';
const String userLogoutApi = '$apiBaseUrl/****';
const String get2faApi = '$apiBaseUrl/**********';
const String getCountriesApi = '$apiBaseUrl/******';
const String getServicesApi = '$apiBaseUrl/******';
const String postContactApi = '$apiBaseUrl/******';
String getBanksApi({
  required int receiveCountryId,
}) =>
    '$apiBaseUrl/banks/$receiveCountryId/*****';
String getBranchesApi({required int bankId}) => '$apiBaseUrl/*****';
const String getPrivacyApi = '$apiBaseUrl/********';
const String post2FAEnableApi = '$apiBaseUrl/*******';
const String post2FADisableApi = '$apiBaseUrl/*******';
const String postCalculationsApi = '$apiBaseUrl/*******';
const String postStoreCalculationsApi = '$apiBaseUrl/*********';
String getSendMoneyRecipientApiUrl({required int id}) =>
    '$apiBaseUrl/sendmoney/$id';
const String postPromoDiscountApi = '$apiBaseUrl/*****';
const String postReferralDiscountApi = '$apiBaseUrl/******';
const String postSendMoneyDataApi = "$apiBaseUrl/******";
const String getGateWaysApi = "$apiBaseUrl/******";
const String postGatewayDetailApi = "$apiBaseUrl/******";
const String postPaymentManually = "$apiBaseUrl/*********";
const String postPaymentSubmitApi = "$apiBaseUrl/*********";
const String getDocumentStatusApi = "$apiBaseUrl/*********";

String getRecipientDataApi({
  required int receiveCountryId,
  required int serviceId,
  required String searchQuery,
}) =>
    '$apiBaseUrl/*********';

String getUserDataApiUrl({required int userId}) =>
    '$apiBaseUrl/***********';
