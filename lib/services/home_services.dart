import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/carousel_slider.dart';
import 'package:velora/models/categories_home_model.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/firestore_services.dart';

abstract class HomeServices {
  Future<void> seedProducts();
  Future<void> seedCategories();
  Future<List<ProductItemModel>> fetchProductItem();
  Future<List<CarouselSliders>> fetchCarouselItem();
  // Future<List<CategoriesHomeModel>> fetchCategoriesItem();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProductItem() async {
    
    final product = await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
    return product;
  }

  @override
  Future<List<CarouselSliders>> fetchCarouselItem() async{
    final product = await firestoreServices.getCollection<CarouselSliders>(
      path: ApiPaths.announcements(),
      builder: (data, documentId) => CarouselSliders.fromMap(data,),
    );
    return product;
  }

  // @override
  // Future<List<CategoriesHomeModel>> fetchCategoriesItem() async{
  //   final product = await firestoreServices.getCollection<CategoriesHomeModel>(
  //     path: ApiPaths.categories(),
  //     builder: (data, documentId) => CategoriesHomeModel.fromMap(data,),
  //   );
  //   return product;
  // }

  @override
  
   Future<void> seedProducts() async {
  for (final product in dummyProducts) {
    await FirestoreServices.instance.setData(
      path: ApiPaths.product(product.id),
      data: product.toMap(),
    );
  }

  }

  @override
 
    Future<void> seedCategories() async {
  for (final category in dummyCategories) {
    await FirestoreServices.instance.setData(
      path: 'categories/${category.id}',
      data: category.toMap(),
    );
  }
}
  

}
