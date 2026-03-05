import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  CategoryList({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.apps},
    {"name": "Vegetables", "icon": Icons.grass},
    {"name": "Fruits", "icon": Icons.apple},
    {"name": "Dairy", "icon": Icons.water_drop},
    {"name": "Snacks", "icon": Icons.fastfood},
    {"name": "Meat", "icon": Icons.kebab_dining},
    {"name": "Bakery", "icon": Icons.bakery_dining},
    {"name": "Beverages", "icon": Icons.local_drink},
  ];

  //  Structured keywords for easier maintenance
  static final Map<String, List<String>> _categoryKeywords = {
    "Vegetables": ["pepper", "cucumber", "onion", "potato", "tomato", "chili", "carrot", "broccoli", "lettuce"],
    "Fruits": ["kiwi", "lemon", "orange", "strawberry", "apple", "banana", "mango", "grape", "melon"],
    "Dairy": ["milk", "yogurt", "egg", "cheese", "butter", "cream"],
    "Meat": ["chicken", "beef", "pork", "fish", "steak", "lamb"],
    "Snacks": ["honey", "ice cream", "sugar", "tea", "water", "crisps", "chocolate", "candy"],
    "Bakery": ["bread", "cake", "muffin", "croissant", "pastry"],
    "Beverages": ["water", "juice", "tea", "coffee", "soda", "coke", "energy drink"],
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final category = categories[i]['name'];
          final icon = categories[i]['icon'];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ChoiceChip(
              avatar: Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.green : Colors.white70,
              ),
              label: Text(category),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onCategorySelected(category);
                }
              },
              selectedColor: Colors.white,
              backgroundColor: Colors.green.shade700,
              labelStyle: TextStyle(
                color: isSelected ? Colors.green : Colors.white,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }

  //  Improved dynamic filtering using Map
  static bool isProductInSelectedCategory(String title, String category) {
    if (category == "All") return true;
    final t = title.toLowerCase();

    // Special case for Snacks/Bakery if they share keywords
    if (category == "Snacks" || category == "Bakery") {
      final snackKeywords = _categoryKeywords["Snacks"] ?? [];
      final bakeryKeywords = _categoryKeywords["Bakery"] ?? [];
      final combined = [...snackKeywords, ...bakeryKeywords];
      return combined.any((keyword) => t.contains(keyword));
    }

    final keywords = _categoryKeywords[category];
    if (keywords == null) return false;

    // Check if any keyword matches the product title
    return keywords.any((keyword) => t.contains(keyword));
  }
}
