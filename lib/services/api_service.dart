import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/category/groceries'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> products = data['products'];
        return products.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load grocery products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
