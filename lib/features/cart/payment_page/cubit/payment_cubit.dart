import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/models/address_model.dart';
import 'package:velora/models/payment_model.dart';
import 'package:velora/services/address_services.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/cart_services.dart';
import 'package:velora/services/checkout_services.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  final AuthServices authServices = AuthServicesImpl();
  final CartServices cartServices = CartServicesImpl();
  final CheckoutServices checkoutServices =
      CheckoutServicesImpel();
  final AddressServices addressServices =
      AddressServicesImpl();

  StreamSubscription<List<AddToCartModel>>? _cartSubscription;

  StreamSubscription<List<PaymentModel>>? _paymentSubscription;

  StreamSubscription<List<AddressModel>>? _addressSubscription;

  List<AddToCartModel> _cartItems = [];

  List<PaymentModel> _paymentCards = [];

  List<AddressModel> _addresses = [];
  PaymentModel? _selectedPaymentOverride;

  void setSelectedPayment(PaymentModel card) {
  _selectedPaymentOverride = card;
  _emitPaymentLoaded();
}
  void watchPaymentData() {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        PaymentError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    emit(PaymentLoading());

    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    _addressSubscription?.cancel();

    _cartSubscription = cartServices
        .watchCartItems(currentUser.uid)
        .listen(
          (cartItems) {
            _cartItems = cartItems;
            _emitPaymentLoaded();
          },
          onError: (error) {
            emit(
              PaymentError(
                message: error.toString(),
              ),
            );
          },
        );

    _paymentSubscription = checkoutServices
        .watchPaymentCards(currentUser.uid)
        .listen(
          (paymentCards) {
            _paymentCards = paymentCards;
            _emitPaymentLoaded();
          },
          onError: (error) {
            emit(
              PaymentError(
                message: error.toString(),
              ),
            );
          },
        );

    _addressSubscription = addressServices
        .watchAddresses(currentUser.uid)
        .listen(
          (addresses) {
            _addresses = addresses;
            _emitPaymentLoaded();
          },
          onError: (error) {
            emit(
              PaymentError(
                message: error.toString(),
              ),
            );
          },
        );
  }

  void _emitPaymentLoaded() {
  final totalItems = _cartItems.fold<int>(
    0,
    (previousValue, element) => previousValue + element.quantity,
  );

  final subTotale = _cartItems.fold<int>(
    0,
    (previousValue, element) => previousValue + element.totalPrice,
  );

  // 👈 الأول أولوية للمتغير المحلي، لو فاضي يبص على isChosen
  PaymentModel? chosenPayment = _selectedPaymentOverride;

  if (chosenPayment == null && _paymentCards.isNotEmpty) {
    final index = _paymentCards.indexWhere(
      (card) => card.isChosen == true,
    );

    if (index != -1) {
      chosenPayment = _paymentCards[index];
    }
  }

  AddressModel? chosenAddress;

  if (_addresses.isNotEmpty) {
    final index = _addresses.indexWhere(
      (address) => address.isChosen == true,
    );

    if (index != -1) {
      chosenAddress = _addresses[index];
    }
  }

  emit(
    PaymentLoaded(
      totalItems: totalItems,
      subTotale: subTotale,
      paymentItem: List.from(_cartItems),
      chosenPayment: chosenPayment,
      chosenAddress: chosenAddress,
    ),
  );
}

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    _addressSubscription?.cancel();

    return super.close();
  }
}