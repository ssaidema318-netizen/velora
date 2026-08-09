part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartLoaded extends CartState {
  final int subTotal;
  final List<AddToCartModel>cartItem;

  const CartLoaded({required this.cartItem, required this.subTotal});
}
final class CartError extends CartState {
  final String message;

  const CartError({required this.message});
}
final class CartQuantityChanged extends CartState {
   final AddToCartModel updatedItem;
   final int subTotal;

  CartQuantityChanged({
    required this.updatedItem, required this.subTotal});
}
final class CartMaxQuantityReached extends CartState{}