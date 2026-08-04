part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProdctDetailsInitial extends ProductDetailsState {}
final class ProdctDetailsLoading extends ProductDetailsState {}
final class ProdctDetailsLoaded extends ProductDetailsState {
  final ProductItemModel productItem;

  ProdctDetailsLoaded({required this.productItem});
}
final class QuantityCounterLoaded extends ProductDetailsState {
  final int value;

  QuantityCounterLoaded({required this.value});
}

final class ProdctDetailsError extends ProductDetailsState {
  final String message;

  ProdctDetailsError({required this.message});

}
final class ProductAddedToCart extends ProductDetailsState{
  final String productId;

  ProductAddedToCart({required this.productId});

}
final class ProductAddingToCart extends ProductDetailsState{
 

}