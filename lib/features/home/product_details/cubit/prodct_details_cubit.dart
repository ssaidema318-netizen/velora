import 'package:bloc/bloc.dart';
import 'package:velora/models/product_item_model.dart';

part 'prodct_details_state.dart';

class ProdctDetailsCubit extends Cubit<ProdctDetailsState> {
  ProdctDetailsCubit() : super(ProdctDetailsInitial());
  void getProductDetails (String id){
    emit(ProdctDetailsLoading());
    Future.delayed(Duration(seconds: 1),
    (){
      final selectedProduct = dummyProducts.firstWhere((product)=>product.id==id);
      emit(ProdctDetailsLoaded(productItem: selectedProduct));
    });
  }
}
