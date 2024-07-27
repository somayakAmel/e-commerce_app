import 'package:dio/dio.dart';
import 'package:e_commerce/features/products_management/view_model/products_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/product.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit() : super(GetProductInitial());
  bool isLoading = false;
  static GetProductCubit get(context) => BlocProvider.of(context);
  List<Product> products = [];
  List<Product> firstPartOfProducts = [];
  List<Product> productsShown = [];
  bool searchActive = false;

  void getProducts() async {
    try {
      emit(GetProductLoading());
      isLoading = true;
      products = await ProductsService(Dio()).getProducts();
      productsShown = products.sublist(0, 6);
      emit(GetProductSuccess());
      isLoading = false;
    } on Exception catch (e) {
      emit(GetProductFailure(
        message: e.toString(),
      ));
      isLoading = false;
    }
  }

  void searchProductsList(value) {
    if (value.isEmpty) {
      productsShown = products;
      searchActive = false;
      emit(GetProductSuccess());
    } else {
      searchActive = true;
      productsShown = products
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    emit(GetProductSuccess());
  }

  void loadMoreProducts() {
    productsShown = products;
    emit(GetProductSuccess());
  }
}
