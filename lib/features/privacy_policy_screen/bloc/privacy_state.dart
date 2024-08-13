part of 'privacy_bloc.dart';

abstract class PrivacyState extends Equatable {
  const PrivacyState();
}

class PrivacyInitial extends PrivacyState {
  @override
  List<Object> get props => [];
}

class PrivacyLoading extends PrivacyState {
  @override
  List<Object> get props => [];
}

class PrivacyLoaded extends PrivacyState {
  final PrivacyTermsModel privacy;

  const PrivacyLoaded({
    required this.privacy,
  });

  @override
  List<Object?> get props => [privacy];
}

class PrivacyError extends PrivacyState {
  final String errorMessage;
  const PrivacyError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
