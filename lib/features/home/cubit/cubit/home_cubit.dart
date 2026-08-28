import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/carousel_slider.dart';
import 'package:velora/models/categories_home_model.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final homeServices = HomeServicesImpl();
  HomeCubit() : super(HomeInitial());
  void getHomeDat() async{
    
    try{
      emit(HomeLoading());
      await homeServices.seedProducts();
      await homeServices.seedCategories();
      final product = await homeServices.fetchProductItem();
      final carouselItem = await homeServices.fetchCarouselItem();
      // final categorylItem = await homeServices.fetchCategoriesItem();
      emit(HomeLoaded(carousel: carouselItem, productItem: product, category: dummyCategories));

    } catch (e){ emit(HomeError(message: e.toString()));}
    
  }
}
