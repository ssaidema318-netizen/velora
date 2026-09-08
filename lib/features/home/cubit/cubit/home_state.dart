part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded({
    required this.carousel,
    required this.productItem,
    required this.category,
    required this.name,
    this.photoUrl,
  });
  final List<CarouselSliders> carousel;
  final List<CategoriesHomeModel> category;
  final String name;
  final List<ProductItemModel> productItem;
  String? photoUrl;
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
