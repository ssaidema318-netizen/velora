import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/home_services.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final HomeServices homeServices;
  final AuthServices authServices;

  FavoriteCubit({
    required this.homeServices,
    required this.authServices,
  }) : super(const FavoriteState());

  Future<void> loadFavorites() async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          errorMessage: 'User is not authenticated',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: FavoriteStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      final favoriteProducts = await homeServices.fetchFavoriteItem(
        currentUser.uid,
      );

      final favoriteIds = favoriteProducts
          .map((product) => product.id)
          .toSet();
      

      emit(
        state.copyWith(
          status: FavoriteStatus.loaded,
          favoriteIds: favoriteIds,
          favoriteProducts: favoriteProducts,
          clearProcessingProductId: true,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  bool isFavorite(String productId) {
    return state.favoriteIds.contains(productId);
  }

  Future<void> toggleFavorite(ProductItemModel product) async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          errorMessage: 'User is not authenticated',
        ),
      );
      return;
    }

    if (state.processingProductId != null) {
      return;
    }

    final wasFavorite = state.favoriteIds.contains(product.id);

    emit(
      state.copyWith(
        status: FavoriteStatus.actionLoading,
        processingProductId: product.id,
        clearErrorMessage: true,
      ),
    );

    try {
      if (wasFavorite) {
        await homeServices.delFavoriteProduct(
          currentUser.uid,
          product.id,
        );
      } else {
        await homeServices.setFavoriteProduct(
          currentUser.uid,
          product,
        );
      }

      final updatedFavoriteIds = Set<String>.from(state.favoriteIds);
      final updatedProducts = List<ProductItemModel>.from(state.favoriteProducts);
      if (wasFavorite) {
        updatedFavoriteIds.remove(product.id);
        updatedProducts.removeWhere((item) => item.id == product.id);
      } else {
        updatedFavoriteIds.add(product.id);
        updatedProducts.add(product);
      }

      emit(
        state.copyWith(
          status: FavoriteStatus.loaded,
          favoriteIds: updatedFavoriteIds,
          favoriteProducts: updatedProducts,
          clearProcessingProductId: true,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          clearProcessingProductId: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

}