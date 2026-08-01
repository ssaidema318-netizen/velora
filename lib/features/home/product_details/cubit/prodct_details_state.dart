part of 'prodct_details_cubit.dart';

sealed class ProdctDetailsState {}

final class ProdctDetailsInitial extends ProdctDetailsState {}
final class ProdctDetailsLoading extends ProdctDetailsState {}
final class ProdctDetailsLoaded extends ProdctDetailsState {
  final ProductItemModel productItem;

  ProdctDetailsLoaded({required this.productItem});
}
final class ProdctDetailsError extends ProdctDetailsState {
  final String message;

  ProdctDetailsError({required this.message});

}
