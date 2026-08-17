part of 'payment_cubit.dart';


sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}
final class PaymentLoading extends PaymentState {}
final class PaymentLoaded extends PaymentState {
  final int totalItems;
  final int subTotale;
  final List<AddToCartModel> paymentItem;
  final PaymentModel? chosenPayment;
  final AddressModel? chosenAddress;

  PaymentLoaded({required this.totalItems, required this.subTotale,  required this.paymentItem, this.chosenPayment, this.chosenAddress});
}
final class PaymentError extends PaymentState {
  final String message;


  PaymentError({required this.message});
}
