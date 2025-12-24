import 'package:flutter/material.dart';
import 'package:grocery_app/data/fake_db.dart';
import '../widgets/item_card.dart';
import 'cart_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = ""; // Search text
  String selectedCategory = "All"; // Selected category

  @override
  Widget build(BuildContext context) {
    // Filters items based on search + category
    final filtered = FakeDB.items.where((item) {
      final matchSearch = (item['name'] as String).toLowerCase().contains(
        query.toLowerCase());
      final matchCat =
          selectedCategory == "All" || item['cat'] == selectedCategory;
      return matchSearch && matchCat;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Grocery"),

        // Cart icon
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search box
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search items...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (v) => setState(() => query = v),
            ),
          ),

          // ♻ Category Chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _catChip("All"),
                _catChip("Fruits"),
                _catChip("Vegetables"),
                _catChip("Dairy"),
              ],
            ),
          ),

          const SizedBox(height: 10),
          // 🛒 Items Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filtered.length,
              itemBuilder: (_, i) => ItemCard(item: filtered[i], index: i),
            ),
          ),
        ],
      ),
    );
  }
  /// Category chip widget (reusable)
  Widget _catChip(String label) {
    final bool selected = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        // Update selected category
        onSelected: (_) => setState(() => selectedCategory = label),
      ),
    );
  }
}
