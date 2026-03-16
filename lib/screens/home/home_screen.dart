import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/product/item_card.dart';
import '../../widgets/home/category_list.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../cart/cart_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ProductProvider>().fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;
    final double childAspectRatio = screenWidth > 600 ? 0.8 : 0.72;
    const Color primaryColor = Color(0xFF0B845C); // Emerald Green

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        title: const Text("Fresh Mart",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1)
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, __) => Badge(
              label: Text(cart.itemCount.toString()),
              backgroundColor: const Color(0xFFFFA000), // Amber Badge
              isLabelVisible: cart.itemCount > 0,
              child: IconButton(
                icon: const Icon(Icons.shopping_basket_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartPage()),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                CustomSearchBar(
                  onChanged: (value) => productProvider.updateSearch(value),
                ),
                CategoryList(
                  selectedCategory: selectedCategory,
                  onCategorySelected: (category) {
                    setState(() => selectedCategory = category);
                    productProvider.updateCategory(category);
                  },
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: primaryColor
                      )
                  );
                }

                if (provider.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text("Error: ${provider.errorMessage}")
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: provider.products.length,
                  itemBuilder: (ctx, i) {
                    return ItemCard(product: provider.products[i]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
