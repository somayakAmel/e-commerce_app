import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shopping_cart/model/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/cache_helper.dart';
// import 'package:uuid/uuid.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);

  List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  void addItem(String id, String title, double price, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity++;
      emit(CartUpdated());
    } else {
      _items.add(CartItemModel(
          id: id, title: title, price: price, quantity: quantity));

      emit(CartUpdated());
    }
  }

  void removeOneItem(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        emit(CartUpdated());
      } else {
        _items.removeAt(index);
        emit(CartUpdated());
      }
    }
    if (_items.isEmpty) {
      emit(CartEmpty());
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    if (_items.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartUpdated());
    }
  }

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  clearCart() {
    _items = [];
    emit(CartEmpty());
  }

  void uploadOrder() {
    FirebaseFirestore.instance.collection("orders").add({
      "items": _items
          .map((item) => {
                "uId": CacheHelper.getData(key: "uId"),
                "id": item.id,
                "title": item.title,
                "price": item.price,
                "quantity": item.quantity
              })
          .toList(),
      "total": totalPrice,
      'date': DateTime.now().toString()
    });
  }
}
