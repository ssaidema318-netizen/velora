part of 'add_new_card_cubit.dart';


sealed class AddNewCardState {}

final class AddNewCardInitial extends AddNewCardState {}
final class AddNewCardLoading extends AddNewCardState {}
final class AddNewCardSuccess extends AddNewCardState {}
final class AddNewCardFailure extends AddNewCardState {
  final String message;

  AddNewCardFailure({required this.message});
}
final class FetchingPaymentMethod extends AddNewCardState{}
final class FetchedPaymentMethod extends AddNewCardState{
  final List<PaymentModel> paymentCards ;

  FetchedPaymentMethod({required this.paymentCards});
}
final class FetchPaymentMethodError extends AddNewCardState{
  final String message;

  FetchPaymentMethodError({required this.message});
}
final class PaymentMethodChosen extends AddNewCardState{
  final PaymentModel chosenPayment;

  PaymentMethodChosen({required this.chosenPayment});
}

final class ConfirmPaymentLoading extends AddNewCardState {}

final class ConfirmPaymentSuccess extends AddNewCardState {}

final class ConfirmPaymentFailure extends AddNewCardState {
  final String message;

  ConfirmPaymentFailure({required this.message});
}