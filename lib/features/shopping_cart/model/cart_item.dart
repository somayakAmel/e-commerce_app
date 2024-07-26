class CartItemModel {
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}
