import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/firestore_services.dart';

abstract class CartServices {
  Future<void> addCartItem(String userId, AddToCartModel cartItem);
  Stream<List<AddToCartModel>> watchCartItems(String userId);
  Future<List<AddToCartModel>> featchCartItems(String userId);
  Future<void> deleteCartItem(String userId, String productId);
  Future<void> updateCartItemQuantity(
    String userId,
    String productId,
    int quantity,
  );
}

class CartServicesImpl implements CartServices {
  final firestoreServices = FirestoreServices.instance;
  final authServices = AuthServicesImpl();
  @override
  Future<List<AddToCartModel>> featchCartItems(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPaths.cartItems(userId),
        builder: (data, documentId) => AddToCartModel.fromMap(data),
      );
  @override
  Future<void> addCartItem(String userId, AddToCartModel cartItem) async {
    final existingCartItems = await firestoreServices.getCollection(
      path: ApiPaths.cartItems(userId),
      builder: (data, documentId) => AddToCartModel.fromMap(data),
    );

    final existingItem = existingCartItems.cast<AddToCartModel?>().firstWhere(
      (item) => item?.productId == cartItem.productId,
      orElse: () => null,
    );

    if (existingItem != null) {
      await firestoreServices.updateData(
        path: ApiPaths.cartItem(userId, cartItem.productId),
        data: {'quantity': existingItem.quantity + cartItem.quantity},
      );
    } else {
      await firestoreServices.setData(
        path: ApiPaths.cartItem(userId, cartItem.productId),
        data: cartItem.toMap(),
      );
    }
  }

  @override
  Stream<List<AddToCartModel>> watchCartItems(String userId) {
    return firestoreServices.collectionStream<AddToCartModel>(
      path: ApiPaths.cartItems(userId),
      builder: (data, documentId) {
        return AddToCartModel.fromMap(data);
      },
    );
  }

  @override
  Future<void> deleteCartItem(String userId, String productId) async {
    await firestoreServices.deleteData(
      path: ApiPaths.cartItem(userId, productId),
    );
  }

  @override
  Future<void> updateCartItemQuantity(
    String userId,
    String productId,
    int quantity,
  ) async => await firestoreServices.updateData(
    path: ApiPaths.cartItem(userId, productId),
    data: {'quantity': quantity},
  );
}
