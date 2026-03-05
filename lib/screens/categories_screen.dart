import 'package:flutter/material.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"name": "Vegetables", "icon": Icons.grass, "color": Colors.green},
    {"name": "Fruits", "icon": Icons.apple, "color": Colors.red},
    {"name": "Dairy", "icon": Icons.water_drop, "color": Colors.blue},
    {"name": "Snacks", "icon": Icons.fastfood, "color": Colors.orange},
    {"name": "Meat", "icon": Icons.kebab_dining, "color": Colors.brown},
    {"name": "Bakery", "icon": Icons.bakery_dining, "color": Colors.amber},
    {"name": "Beverages", "icon": Icons.local_drink, "color": Colors.cyan},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final cat = categories[i];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductsScreen(categoryName: cat['name']),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: cat['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: cat['color'].withOpacity(0.5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cat['icon'], size: 50, color: cat['color']),
                  const SizedBox(height: 10),
                  Text(
                    cat['name'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
