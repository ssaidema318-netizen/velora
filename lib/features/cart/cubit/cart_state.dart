part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartLoaded extends CartState {
  final List<AddToCartModel>cartItem;

  const CartLoaded({required this.cartItem});
}
final class CartError extends CartState {
  final String message;

  const CartError({required this.message});
}
void incrementCounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity = quantity > 1 ? quantity - 1 : 1;

    emit(QuantityCounterLoaded(value: quantity));
  }
