import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product/item_card.dart';
import '../../widgets/home/category_list.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          final filteredProducts = provider.products.where((p) {
            return CategoryList.isProductInSelectedCategory(p.title, categoryName);
          }).toList();

          if (filteredProducts.isEmpty) {
            return const Center(
              child: Text("No products found in this category!"),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (ctx, i) {
              return ItemCard(product: filteredProducts[i]);
            },
          );
        },
      ),
    );
  }
}
