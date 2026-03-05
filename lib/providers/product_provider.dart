import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../widgets/category_list.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = "";
  String _selectedCategory = "All";

  List<Product> get products =>
      _filteredProducts.isEmpty &&
          _searchQuery.isEmpty &&
          _selectedCategory == "All"
      ? _allProducts
      : _filteredProducts;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _allProducts = await _apiService.fetchProducts();
      _applyFilter(); // Initial filter
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logic moved from UI to Provider
  void updateSearch(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilter();
  }

  void updateCategory(String category) {
    _selectedCategory = category;
    _applyFilter();
  }

  void _applyFilter() {
    _filteredProducts = _allProducts.where((p) {
      final matchesSearch = p.title.toLowerCase().contains(_searchQuery);
      final matchesCategory = CategoryList.isProductInSelectedCategory(
        p.title,
        _selectedCategory,
      );
      return matchesSearch && matchesCategory;
    }).toList();
    notifyListeners();
  }
}
