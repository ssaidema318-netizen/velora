import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  int quantity = 1;
  ProductDetailsCubit() : super(ProdctDetailsInitial());
  void getProductDetails(String id) {
    // emit(ProdctDetailsLoading());
    Future.delayed(Duration(seconds: 0), () {
      final selectedProduct = dummyProducts.firstWhere(
        (product) => product.id == id,
      );
      emit(ProdctDetailsLoaded(productItem: selectedProduct));
    });
  }

  void incrementCounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity = quantity > 1 ? quantity - 1 : 1;

    emit(QuantityCounterLoaded(value: quantity));
  }

  void addToCart(String productId) {
    final product = dummyProducts.firstWhere(
      (element) => element.id == productId,
    );
    emit(ProductAddingToCart());
    final cartItem = AddToCartModel(
      name: product.name,
      productId: productId,
      quantity: quantity,
      imageUrl: product.imageUrl,
      price: (product.price * quantity).toInt(),
      rating: product.rating,
      reviewCount: product.reviewCount,
    );
    dummyCart.add(cartItem);
    Future.delayed(const Duration(seconds: 1), () {
      emit(ProductAddedToCart(productId: productId));
    });
  }
}
