import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final CartServices cartServices = CartServicesImpl();
  final AuthServices authServices = AuthServicesImpl();

  StreamSubscription<List<AddToCartModel>>? _cartSubscription;

  // ─────────────────────────────────────────────
  // Realtime Cart
  // ─────────────────────────────────────────────

  void watchCart() {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        CartError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    emit(CartLoading());

    // Cancel previous listener if one already exists.
    _cartSubscription?.cancel();

    _cartSubscription = cartServices
        .watchCartItems(currentUser.uid)
        .listen(
          (cartItems) {
            final subTotal = cartItems.fold<int>(
              0,
              (previousValue, element) =>
                  previousValue + element.totalPrice,
            );

            emit(
              CartLoaded(
                cartItem: List.from(cartItems),
                subTotal: subTotal,
              ),
            );
          },
          onError: (error) {
            emit(
              CartError(
                message: error.toString(),
              ),
            );
          },
        );
  }

  // ─────────────────────────────────────────────
  // Update Quantity
  // ─────────────────────────────────────────────

  Future<void> incrementCounter(
    AddToCartModel cartItem,
  ) async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        CartError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    try {
      if (cartItem.quantity >= cartItem.stock) {
        emit(CartMaxQuantityReached());
        return;
      }

      final newQuantity = cartItem.quantity + 1;

      await cartServices.updateCartItemQuantity(
        currentUser.uid,
        cartItem.productId,
        newQuantity,
      );
    } catch (e) {
      emit(
        CartError(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> decrementCounter(
    AddToCartModel cartItem,
  ) async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        CartError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    if (cartItem.quantity <= 1) {
      return;
    }

    try {
      final newQuantity = cartItem.quantity - 1;

      await cartServices.updateCartItemQuantity(
        currentUser.uid,
        cartItem.productId,
        newQuantity,
      );
    } catch (e) {
      emit(
        CartError(
          message: e.toString(),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────
  // Remove Item
  // ─────────────────────────────────────────────

  Future<void> removeItem(
    AddToCartModel cartItem,
  ) async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        CartError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    try {
      await cartServices.deleteCartItem(
        currentUser.uid,
        cartItem.productId,
      );
    } catch (e) {
      emit(
        CartError(
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
    _cartSubscription?.cancel();
    return super.close();
  }
}