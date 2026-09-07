import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/carousel_slider.dart';
import 'package:velora/models/categories_home_model.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();
  HomeCubit() : super(HomeInitial()) {
      debugPrint('🔥🔥 HOME CUBIT CREATED: ${identityHashCode(this)}');

  }
  @override
Future<void> close() {
  debugPrint('❌❌ HOME CUBIT CLOSED: ${identityHashCode(this)}');
  return super.close();
}
  // Inside home_cubit.dart
void getHomeData() async { // Fixed typo: getHomeDat -> getHomeData
  debugPrint('🚀🚀 HOME LOAD START: ${identityHashCode(this)}');
  try {
    emit(HomeLoading());

    // Run all three fetch operations concurrently
    final results = await Future.wait([
      homeServices.fetchProductItem(),
      homeServices.fetchCategoriesItem(),
    ]);

    final product = (results[0] as List).cast<ProductItemModel>();
    final categories = (results[1] as List).cast<CategoriesHomeModel>();

    emit(
      HomeLoaded(
        carousel: dummySliders, // Replaced dummySliders
        productItem: product,
        category: categories,
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('ERROR: $e');
    debugPrintStack(stackTrace: stackTrace);
    emit(HomeError(message: e.toString()));
  }
}

  
}
