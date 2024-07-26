import 'package:dio/dio.dart';

import '../model/product.dart';

class ProductsService {
  final Dio dio;
  ProductsService(this.dio);

  Future<List<Product>> getProducts() async {
    try {
      var response = await dio
          .get("https://fake-store-api.mock.beeceptor.com/api/products");
      List<dynamic> jsonData = response.data;
      List<Product> products = [];

      for (var product in jsonData) {
        Product productModel = Product.fromJson(product);
        products.add(productModel);
      }

      return products;
    } on Exception {
      return [];
    }
  }
}
