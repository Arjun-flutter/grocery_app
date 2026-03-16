import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../widgets/home/category_list.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = "";
  String _selectedCategory = "All";

  // Getters
  List<Product> get products => _filteredProducts;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  String get selectedCategory => _selectedCategory;

  // Fetch products
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _allProducts = await _apiService.fetchProducts();

      // Initial filter
      _applyFilter();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search update
  void updateSearch(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilter();
  }

  // Category update
  void updateCategory(String category) {
    _selectedCategory = category;
    _applyFilter();
  }

  // Filter Logic
  void _applyFilter() {
    _filteredProducts = _allProducts.where((product) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery);
      final matchesCategory =
          _selectedCategory == "All" ||
          CategoryList.isProductInSelectedCategory(
            product.title,
            _selectedCategory,
          );

      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }
}
