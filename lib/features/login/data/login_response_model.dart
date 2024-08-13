import 'package:anexpress/features/login/data/user_info_model.dart';
import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String? message;
  final String? accessToken;
  final String? tokenType;
  final UserInfoModel? user;

  const LoginResponseModel({
    this.message,
    this.accessToken,
    this.tokenType,
    this.user,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        accessToken = json['access_token'] as String?,
        tokenType = json['token_type'] as String?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? UserInfoModel.fromJson(json['user'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'message': message,
        'access_token': accessToken,
        'token_type': tokenType,
        'user': user?.toJson()
      };

  @override
  List<Object?> get props => [message, accessToken, tokenType, user];
}
