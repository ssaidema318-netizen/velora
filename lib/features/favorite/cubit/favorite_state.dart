part of 'favorite_cubit.dart';

enum FavoriteStatus {
  initial,
  loading,
  loaded,
  actionLoading,
  error,
  pageEmpty,
}

class FavoriteState {
  final FavoriteStatus status;
  final Set<String> favoriteIds;
  final List<ProductItemModel> favoriteProducts;
  final String? processingProductId;
  final String? errorMessage;

  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favoriteIds = const {},
    this.favoriteProducts = const [],
    this.processingProductId,
    this.errorMessage,
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    Set<String>? favoriteIds,
    List<ProductItemModel>? favoriteProducts,
    String? processingProductId,
    String? errorMessage,
    bool clearProcessingProductId = false,
    bool clearErrorMessage = false,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      processingProductId: clearProcessingProductId
          ? null
          : processingProductId ?? this.processingProductId,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}