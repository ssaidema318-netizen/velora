import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/models/address_model.dart';
import 'package:velora/models/payment_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  
  PaymentCubit() : super(PaymentInitial());
  void getPaymentItem() async {
    PaymentModel? chosenPaymentCard;
    AddressModel? chosenAddress;
    emit(PaymentLoading());
    final totalItems = dummyCart.fold<int>(
      0,
      (((previousValue, element) => previousValue + element.quantity)),
    );
    final subTotale = dummyCart.fold<int>(
      0,
      (((previousValue, element) => previousValue + element.totalPrice)),
    );
   if (dummyPayment.isNotEmpty) {
  final index = dummyPayment.indexWhere(
    (card) => card.isChoiSen == true,
  );

  chosenPaymentCard = dummyPayment[index == -1 ? 0 : index];
}
   if (dummyAddress.isNotEmpty) {
  final index = dummyAddress.indexWhere(
    (location) => location.isChosen == true,
  );

  chosenAddress = dummyAddress[index == -1 ? 0 : index];
}

    emit(
      PaymentLoaded(
        totalItems: totalItems,
        subTotale: subTotale,
        paymentItem: dummyCart,
        chosenPayment: chosenPaymentCard,
        chosenAddress: chosenAddress,
      ),
    );
  }
}
