part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeLoaded extends HomeState {
  HomeLoaded({required this.carousel, required this.productItem, required this.category});
  final List<CarouselSlider> carousel;
  final List<CategoriesHomeModel> category;

  final List<ProductItemModel> productItem;
}
final class HomeError extends HomeState{
  final String message;

  HomeError({required this.message});
}
