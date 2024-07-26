part of 'get_product_cubit.dart';

@immutable
sealed class GetProductState {}

final class GetProductInitial extends GetProductState {}

final class GetProductLoading extends GetProductState {}

final class GetProductSuccess extends GetProductState {}

final class GetProductFailure extends GetProductState {
  final String message;

  GetProductFailure({required this.message});
}

final class PaginationLoading extends GetProductState {
  final List? products;

  PaginationLoading({required this.products});
}

final class PaginationLoaded extends GetProductState {
  final List? products;

  PaginationLoaded({required this.products});
}
