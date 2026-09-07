import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/cart_services.dart';
import 'package:velora/services/product_details_services.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final productDetailsServices = ProductDetailsServicesImpl();
  final cartServices = CartServicesImpl();
  final authservices = AuthServicesImpl();
  ProductItemModel? currentProduct;
  int quantity = 1;
  ProductDetailsCubit() : super(ProdctDetailsInitial());
  void getProductDetails(String id) async{
    emit(ProdctDetailsLoading());
    try{
    final slectedItem = await productDetailsServices.featchProdctDetails(id);
    emit(ProdctDetailsLoaded(productItem: slectedItem));
    }catch (e){emit(ProdctDetailsError(message: e.toString()));}
  }

  void incrementCounter(String productId) async{
    final product =  await productDetailsServices.featchProdctDetails(productId);
    if (quantity >= product.stock) {
      emit(QuantityMaxReached(value: quantity));
      return;
    }
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity = quantity > 1 ? quantity - 1 : 1;

    emit(QuantityCounterLoaded(value: quantity));
  }

  Future<void> addToCart(String productId) async {
  emit(ProductAddingToCart());

  try {
    final currentUser = authservices.currentUser();

    if (currentUser == null) {
      emit(
        ProductAddToCartError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    final product =
        await productDetailsServices.featchProdctDetails(productId);

    final cartItem = AddToCartModel(
      name: product.name,
      productId: productId,
      quantity: quantity,
      imageUrl: product.imageUrl,
      price: product.price.toInt(),
      rating: product.rating,
      reviewCount: product.reviewCount,
      stock: product.stock,
    );

   await cartServices.addCartItem(
  currentUser.uid,
  cartItem,
);
    emit(
      ProductAddedToCart(
        productId: productId,
      ),
    
    );
    
  } catch (e) {
    emit(
      ProductAddToCartError(
        message: e.toString(),
      ),
    );
  }
}
}
