import 'package:flutter/material.dart';
import '../model/food.dart';
import '../data/cart_data.dart';

class DetailMenuPage extends StatefulWidget {
  final Food food;

  const DetailMenuPage({super.key, required this.food});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  String selectedOption = "";

  List<String> getOptions() {
    switch (widget.food.category) {
      case "Makanan":
        return ["Pedas", "Tidak Pedas"];
      case "Minuman":
        return ["Manis", "Tawar"];
      case "Snack":
        return ["Kecil", "Sedang"];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = getOptions();

    return Scaffold(
      appBar: AppBar(title: Text(widget.food.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.fastfood, size: 120),
            ),
            const SizedBox(height: 16),

            Text(
              widget.food.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Rp ${widget.food.price}",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 24),
            const Text(
              "Pilih Opsi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: options.map((opt) {
                final selected = selectedOption == opt;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedOption = opt);
                    },
                    child: Card(
                      color: selected
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            opt,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedOption.isEmpty
                    ? null
                    : () {
                  CartData.add(widget.food, selectedOption);
                  Navigator.pop(context);
                },
                child: const Text("Tambah ke Keranjang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
