part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class QuantityChanged extends ProductDetailsState {}

final class FavoriteChanged extends ProductDetailsState {}
