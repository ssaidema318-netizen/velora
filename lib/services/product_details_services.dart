import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/firestore_services.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> featchProdctDetails(String id);
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

 
}
