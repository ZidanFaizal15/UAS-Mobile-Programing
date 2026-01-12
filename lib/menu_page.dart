import 'package:flutter/material.dart';
import 'model/food.dart';
import 'detail_menu_page.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  final List<Food> menu = [
    Food(
      name: "Nasi Goreng",
      price: 15000,
      category: "Makanan",
      image: "assets/images/nasi goreng.jpeg",
    ),
    Food(
      name: "Ayam Goreng",
      price: 20000,
      category: "Makanan",
      image: "assets/images/ayam bakar.jpg",
    ),
    Food(
      name: "Es Jeruk",
      price: 8000,
      category: "Minuman",
      image: "assets/images/es jeruk.jpg",
    ),
    Food(
      name : "Es Teh",
      price: 5000,
      category: "Minuman",
      image: "assets/images/es teh.jpg"
    ),
    Food(
      name: "Kentang Goreng",
      price: 10000,
      category: "Snack",
      image: "assets/images/kentang goreng.jpg",
    ),
  ];

  List<Food> byCategory(String category) =>
      menu.where((e) => e.category == category).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Menu"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Makanan"),
              Tab(text: "Minuman"),
              Tab(text: "Snack"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _grid(context, byCategory("Makanan")),
            _grid(context, byCategory("Minuman")),
            _grid(context, byCategory("Snack")),
          ],
        ),
      ),
    );
  }

  Widget _grid(BuildContext context, List<Food> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final food = items[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailMenuPage(food: food),
              ),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      food.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 40),
                        );
                      },
                    ),
                  ),
                ),

                // TEXT
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp ${food.price}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
