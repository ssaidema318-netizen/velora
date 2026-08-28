import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/firestore_services.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> featchProdctDetails(String id);
  Future<void> addtoCard(AddToCartModel cartItem, String productId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<ProductItemModel> featchProdctDetails(String productId) async {
    final selctedProduct = await firestoreServices
        .getDocument<ProductItemModel>(
          path: ApiPaths.product(productId),
          builder: (data, documentId) =>
              ProductItemModel.fromMap(data, documentId),
        );
    return selctedProduct;
  }

  @override
  Future<void> addtoCard(AddToCartModel cartItem, String id) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('cart')
        .doc(cartItem.productId);

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.update({
        'quantity': FieldValue.increment(cartItem.quantity),
      });
    } else {
      await docRef.set(cartItem.toMap());
    }
  }
}
