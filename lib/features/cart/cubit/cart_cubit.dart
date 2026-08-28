import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/add_to_cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  void getCartItems() async{
  emit(CartLoading());
  final subTotal = dummyCart.fold<int>(0, ((previousValue, element) => previousValue+element.totalPrice));
  emit(CartLoaded(cartItem: List.from(dummyCart) , subTotal: subTotal,));
}
void refreshCart() {
      final subTotal = dummyCart.fold<int>(0, ((previousValue, element) => previousValue+element.totalPrice));

  emit(CartLoaded(cartItem: List.from(dummyCart), subTotal: subTotal));
}
void removeItem(AddToCartModel cartItem){
  
  dummyCart.remove(cartItem);
  final subTotal = dummyCart.fold<int>(0, ((previousValue, element) => previousValue+element.totalPrice));
  emit(CartLoaded(cartItem: List.from(dummyCart), subTotal: subTotal));

}
void incrementCounter(AddToCartModel cartItem) {
  
  final int indix = dummyCart.indexWhere((element) => element.productId==cartItem.productId);
  final current = dummyCart[indix];

  // Don't let the quantity go past what's actually in stock.
  if (current.quantity >= current.stock) {
    emit(CartMaxQuantityReached());
    emit(CartQuantityChanged(updatedItem: current, subTotal: dummyCart.fold(
      0,
      (previousValue, element) => previousValue + element.totalPrice,
    )));
    return;
  }

  final updatedItem = current.copyWith(
   quantity:   current.quantity+1

  );
   dummyCart[indix]=updatedItem;

    emit(CartQuantityChanged(updatedItem:updatedItem,subTotal: dummyCart.fold(
      0,
      (previousValue, element) => previousValue + element.totalPrice,
    ), ) );
  }
void decrementCounter(AddToCartModel cartItem) {
  
  final int indix = dummyCart.indexWhere((element) => element.productId==cartItem.productId);
  final updatedItem = dummyCart[indix].copyWith(
   quantity:   dummyCart[indix].quantity>1?dummyCart[indix].quantity-1:1

  );
   dummyCart[indix]=updatedItem;

    emit(CartQuantityChanged(updatedItem:updatedItem,subTotal: dummyCart.fold(
      0,
      (previousValue, element) => previousValue + element.totalPrice,
    ),));
    
  }

 

}
