import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/carousel_slider.dart';
import 'package:velora/models/categories_home_model.dart';
import 'package:velora/models/product_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void getHomeDat() {
    emit(HomeLoading());
    Future.delayed(const Duration(seconds: 3), () {
      emit(HomeLoaded(carousel: dummySliders, productItem: dummyProducts, category: dummyCategories));
    });
  }
}
