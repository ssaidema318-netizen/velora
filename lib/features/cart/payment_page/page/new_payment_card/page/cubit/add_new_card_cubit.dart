import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/payment_model.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/checkout_services.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

  final CheckoutServices checkoutServices =
      CheckoutServicesImpel();

  final AuthServices authServices =
      AuthServicesImpl();

  PaymentModel? selectedPaymentMethod;

  StreamSubscription<List<PaymentModel>>?
      _paymentCardsSubscription;
  
  // ─────────────────────────────────────────────
  // Watch Payment Methods
  // ─────────────────────────────────────────────

  void watchPaymentMethods() {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        FetchPaymentMethodError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    emit(FetchingPaymentMethod());

    _paymentCardsSubscription?.cancel();

    _paymentCardsSubscription = checkoutServices
        .watchPaymentCards(currentUser.uid)
        .listen(
          (paymentCards) {
            if (paymentCards.isEmpty) {
              emit(
                FetchPaymentMethodError(
                  message: 'No Payment Method Found!',
                ),
              );
              return;
            }

            final chosenCard = paymentCards.cast<PaymentModel?>().firstWhere(
              (card) => card?.isChosen == true,
              orElse: () => null,
            );

            selectedPaymentMethod = chosenCard;

            if (chosenCard != null) {
              emit(
                PaymentMethodChosen(
                  chosenPayment: chosenCard,
                ),
              );
            }

            emit(
              FetchedPaymentMethod(
                paymentCards: paymentCards,
              ),
            );
          },
          onError: (error) {
            emit(
              FetchPaymentMethodError(
                message: error.toString(),
              ),
            );
          },
        );
  }

  // ─────────────────────────────────────────────
  // Add New Card
  // ─────────────────────────────────────────────

  Future<void> addNewCard(
    String cardHolder,
    String cardNumber,
    String expiryDate,
    String cvv,
  ) async {
    emit(AddNewCardLoading());

    try {
      final currentUser = authServices.currentUser();

      if (currentUser == null) {
        emit(
          AddNewCardFailure(
            message: 'User is not logged in',
          ),
        );
        return;
      }

      final newCard = PaymentModel(
        id: DateTime.now().toIso8601String(),
        cardHolderName: cardHolder,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvv: cvv,
      );

      await checkoutServices.addNewCard(
        currentUser.uid,
        newCard,
      );

      emit(AddNewCardSuccess());
    } catch (e) {
      emit(
        AddNewCardFailure(
          message: e.toString(),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────
  // Change Payment Method
  // ─────────────────────────────────────────────

  Future<void> changePaymentMethod(
    String id,
  ) async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        PaymentMethodChangeFailure(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    try {
      await checkoutServices.choosePaymentMethod(
        currentUser.uid,
        id,
      );
    } catch (e) {
      emit(
        PaymentMethodChangeFailure(
          message: e.toString(),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────
  // Confirm Payment
  // ─────────────────────────────────────────────

  Future<void> confirmPayment() async {
    if (selectedPaymentMethod == null) {
      emit(
        ConfirmPaymentFailure(
          message: 'Please select a payment method',
        ),
      );
      return;
    }

    final chosenPayment = selectedPaymentMethod!;

    emit(ConfirmPaymentLoading());

    try {
      // At this point the selected payment method
      // is already persisted in Firestore.
      emit(ConfirmPaymentSuccess(chosenPayment: chosenPayment));
    } catch (e) {
      emit(
        ConfirmPaymentFailure(
          message: e.toString(),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────
  // Close
  // ─────────────────────────────────────────────

  @override
  Future<void> close() {
    _paymentCardsSubscription?.cancel();
    return super.close();
  }
}