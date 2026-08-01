part of 'prodct_details_cubit.dart';

sealed class ProdctDetailsState {}

final class ProdctDetailsInitial extends ProdctDetailsState {}
final class ProdctDetailsLoading extends ProdctDetailsState {}
final class ProdctDetailsLoaded extends ProdctDetailsState {}
final class ProdctDetailsError extends ProdctDetailsState {}
