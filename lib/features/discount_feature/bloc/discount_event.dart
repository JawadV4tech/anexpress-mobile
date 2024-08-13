part of 'discount_bloc.dart';

sealed class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

class GetDiscountEvent extends DiscountEvent {
  final Map<String, dynamic> requestMap;
  final String apiUrl;

  const GetDiscountEvent({required this.requestMap, required this.apiUrl});

  @override
  List<Object> get props => [requestMap, apiUrl];
}

class DiscountResetEvent extends DiscountEvent {
  const DiscountResetEvent();

  @override
  List<Object> get props => [];
}
