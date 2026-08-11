part of 'payment_cubit.dart';


sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}
final class PaymentLoading extends PaymentState {}
final class PaymentLoaded extends PaymentState {
  final int totalItems;
  final int subTotale;
  final List<AddToCartModel> paymentItem;

  PaymentLoaded({required this.totalItems, required this.subTotale,  required this.paymentItem});
}
final class PaymentError extends PaymentState {
  final String message;


  PaymentError({required this.message});
}
