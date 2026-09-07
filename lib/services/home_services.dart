import 'package:flutter/foundation.dart'; // import مهم جداً لاستخدام compute
import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/carousel_slider.dart';
import 'package:velora/models/categories_home_model.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/firestore_services.dart';

//  دالة Top-level خارج الكلاس ليتمكن الـ Isolate من تشغيلها بشكل مستقل
List<ProductItemModel> _parseProductsIsolate(List<Map<String, dynamic>> rawDataList) {
  return rawDataList.map((data) {
    final String documentId = data['_documentId'] as String? ?? '';
    return ProductItemModel.fromMap(data, documentId);
  }).toList();
}

abstract class HomeServices {
  Future<void> seedProducts();
  Future<void> seedCategories();
  Future<List<ProductItemModel>> fetchProductItem();
  Future<List<ProductItemModel>> fetchFavoriteItem(String userId);
  Future<List<CarouselSliders>> fetchCarouselItem();
  Future<List<CategoriesHomeModel>> fetchCategoriesItem();
  Future<void> setFavoriteProduct(String userId, ProductItemModel productItem);
  Future<void> delFavoriteProduct(String userId, String productId);
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProductItem() async {
    // 1. جلب القائمة الخام (Maps) فقط بدون معالجة ثقيلة في الـ Main Thread
    final rawDataList = await firestoreServices.getCollection<Map<String, dynamic>>(
      path: ApiPaths.products(),
      builder: (data, documentId) {
        final map = Map<String, dynamic>.from(data);
        map['_documentId'] = documentId;
        return map;
      },
    );

    // 2. نقل عملية تحويل البيانات إلى Isolate منفصل باستخدام compute
    return await compute(_parseProductsIsolate, rawDataList);
  }

  @override
  Future<List<ProductItemModel>> fetchFavoriteItem(String userId) async {
    final rawDataList = await firestoreServices.getCollection<Map<String, dynamic>>(
      path: ApiPaths.favoriteProducts(userId),
      builder: (data, documentId) {
        final map = Map<String, dynamic>.from(data);
        map['_documentId'] = documentId;
        return map;
      },
    );

    return await compute(_parseProductsIsolate, rawDataList);
  }

  @override
  Future<List<CarouselSliders>> fetchCarouselItem() async {
    final product = await firestoreServices.getCollection<CarouselSliders>(
      path: ApiPaths.announcements(),
      builder: (data, documentId) => CarouselSliders.fromMap(data),
    );
    return product;
  }

  @override
  Future<List<CategoriesHomeModel>> fetchCategoriesItem() async {
    final product = await firestoreServices.getCollection<CategoriesHomeModel>(
      path: ApiPaths.category(),
      builder: (data, documentId) =>
          CategoriesHomeModel.fromMap(data, documentId),
    );
    return product;
  }

  @override
  Future<void> seedProducts() async {
    final writes = dummyProducts.map(
      (product) => (
        path: ApiPaths.product(product.id),
        data: product.toMap(),
      ),
    ).toList();

    await firestoreServices.batchSetData(writes);
  }

  @override
  Future<void> seedCategories() async {
    final writes = dummyCategories.map(
      (category) => (
        path: ApiPaths.categories(category.id),
        data: category.toMap(),
      ),
    ).toList();

    await firestoreServices.batchSetData(writes);
  }

  Future<void> seedDatabase() async {
    final homeServices = HomeServicesImpl();

    await homeServices.seedProducts();
    await homeServices.seedCategories();
  }

  @override
  Future<void> setFavoriteProduct(
    String userId,
    ProductItemModel productItem,
  ) async {
    await firestoreServices.setData(
      path: ApiPaths.favoriteProduct(userId, productItem.id),
      data: productItem.toMap(),
    );
  }

  @override
  Future<void> delFavoriteProduct(String userId, String productId) async {
    await firestoreServices.deleteData(
      path: ApiPaths.favoriteProduct(userId, productId),
    );
  }
}