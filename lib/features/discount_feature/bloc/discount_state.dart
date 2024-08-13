part of 'discount_bloc.dart';

sealed class DiscountState extends Equatable {
  const DiscountState();
}

final class DiscountInitial extends DiscountState {
  @override
  List<Object> get props => [];
}

class DiscountLoading extends DiscountState {
  @override
  List<Object> get props => [];
}

class DiscountLoaded extends DiscountState {
  final double discount;
  final bool isPromo;

  const DiscountLoaded({
    required this.discount,
    required this.isPromo,
  });

  @override
  List<Object?> get props => [discount, isPromo];
}

class DiscountError extends DiscountState {
  final String errorMessage;
  const DiscountError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
