import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/product.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  int quantity = 1;
  List<Product> favoriteProducts = [];
  void incrementQuantity() {
    quantity++;
    emit(QuantityChanged());
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(QuantityChanged());
    }
  }

  void resetQuantity() {
    quantity = 1;
    emit(QuantityChanged());
  }

  double calculateRating(Product product) {
    if (product.reviews != []) {
      double sum = 0.0;
      double result = 0.0;
      for (int i = 0; i < product.reviews!.length; i++) {
        sum += product.reviews![i].rating;
        if (i == product.reviews!.length - 1) {
          result = sum / product.reviews!.length;
        }
      }
      return result;
    } else {
      return 0.0;
    }
  }

  void toggleFavorite(Product product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
    emit(FavoriteChanged());
  }

  bool isFavoriteOrNot(Product product) {
    if (favoriteProducts.contains(product)) {
      return true;
    } else {
      return false;
    }
  }

  void removeFavorite(Product product) {
    favoriteProducts.remove(product);
    emit(FavoriteChanged());
  }

  void clearFavorite() {
    favoriteProducts = [];
    emit(FavoriteChanged());
  }
}
