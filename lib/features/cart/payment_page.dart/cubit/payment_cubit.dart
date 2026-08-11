import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  void getPaymentItem() async {
    emit(PaymentLoading());
    final totalItems = dummyCart.fold<int>(
      0,
      (((previousValue, element) => previousValue + element.quantity)),
    );
    final subTotale = dummyCart.fold<int>(
      0,
      (((previousValue, element) => previousValue + element.totalPrice)),
    );
    emit(PaymentLoaded(totalItems: totalItems, subTotale: subTotale, paymentItem: dummyCart));
  }
}
