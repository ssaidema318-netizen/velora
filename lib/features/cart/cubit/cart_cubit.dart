import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  void getCartItems() async{
  emit(CartLoading());
  emit(CartLoaded(cartItem: dummyCart));
}
void refreshCart() {
  emit(CartLoaded(cartItem: List.from(dummyCart)));
}
void removeItem(AddToCartModel cartItem){
  dummyCart.remove(cartItem);
  emit(CartLoaded(cartItem: List.from(dummyCart)));

}
void incrementCounter(String productId) {
    quantity++;
    emit(C(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity = quantity > 1 ? quantity - 1 : 1;

    emit(QuantityCounterLoaded(value: quantity));
  }

}
