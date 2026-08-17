import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/payment_model.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  PaymentModel? selectedPaymentMethod;
  AddNewCardCubit() : super(AddNewCardInitial());
  void addNewCard(
    String cardHolder,
    String cardNumber,
    String expiryDate,
    String cvv,
  ) {
    emit(AddNewCardLoading());
    final newCard = PaymentModel(
      id: DateTime.now().toIso8601String(),
      cardHolderName: cardHolder,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cvv: cvv,
    );
    Future.delayed(const Duration(seconds: 1), () {
      dummyPayment.add(newCard);
      emit(AddNewCardSuccess());
    });
  }

  Future<void> fetchPaymentMethod() async {
    emit(FetchingPaymentMethod());
    await Future.delayed(Duration(seconds: 1), () {
      
      if (dummyPayment.isNotEmpty) {
        final previousIndex = dummyPayment.indexWhere(
        (test) => test.isChoiSen == true,
        
      );
      if(previousIndex == -1){
        dummyPayment[0]=dummyPayment[0].copyWith(isChoiSen: true,);
        emit(PaymentMethodChosen(chosenPayment: dummyPayment[0]));

      } else{emit(PaymentMethodChosen(chosenPayment: dummyPayment[previousIndex]));
}
      
        emit(FetchedPaymentMethod(paymentCards: dummyPayment));
      } else {
        emit(FetchPaymentMethodError(message: "No Payment Method Found!"));
      }
    });
  }

 void changePaymentMethod(String id) {
  selectedPaymentMethod = dummyPayment.firstWhere(
    (card) => card.id == id,
  );

  emit(
    PaymentMethodChosen(
      chosenPayment: selectedPaymentMethod!,
    ),
  );
}
Future<void> confirmPayment() async {
  if (selectedPaymentMethod == null) {
    emit(
      ConfirmPaymentFailure(
        message: 'Please select a payment method',
      ),
    );
    return;
  }

  emit(ConfirmPaymentLoading());

  await Future.delayed(const Duration(seconds: 1));

  final selectedId = selectedPaymentMethod!.id;

  for (int i = 0; i < dummyPayment.length; i++) {
    dummyPayment[i] = dummyPayment[i].copyWith(
      isChoiSen: dummyPayment[i].id == selectedId,
    );
  }
  print(
  'Selected after confirm: '
  '${dummyPayment.firstWhere((card) => card.isChoiSen).cardNumber}',
);

  emit(ConfirmPaymentSuccess());
}
}
