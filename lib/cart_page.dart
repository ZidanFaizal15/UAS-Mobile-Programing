import 'package:flutter/material.dart';
import 'data/cart_data.dart';
import 'data/order_data.dart';
import 'model/order.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  String payment = "COD";

  @override
  void dispose() {
    nameCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        centerTitle: true,
      ),
      body: CartData.cart.isEmpty
          ? const Center(
        child: Text(
          "Keranjang masih kosong",
          style: TextStyle(fontSize: 16),
        ),
      )
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ===== LIST KERANJANG =====
              Expanded(
                child: ListView.builder(
                  itemCount: CartData.cart.length,
                  itemBuilder: (context, index) {
                    final item = CartData.cart[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.fastfood),
                        title: Text(
                          item.food.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${item.option} • Rp ${item.food.price} x ${item.qty}",
                        ),
                        trailing: Text(
                          "Rp ${item.subtotal}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              /// ===== FORM PEMESAN =====
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Nama Pemesan",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),

              const SizedBox(height: 10),

              /// ===== PEMBAYARAN =====
              DropdownButtonFormField<String>(
                value: payment,
                decoration: const InputDecoration(
                  labelText: "Metode Pembayaran",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "COD",
                    child: Text("COD"),
                  ),
                  DropdownMenuItem(
                    value: "Transfer",
                    child: Text("Transfer"),
                  ),
                ],
                onChanged: (value) {
                  setState(() => payment = value!);
                },
              ),

              const SizedBox(height: 14),

              /// ===== TOTAL =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rp ${CartData.total}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// ===== TOMBOL PESAN =====
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Buat Pesanan",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (nameCtrl.text.isEmpty ||
                      addressCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text("Nama dan alamat wajib diisi"),
                      ),
                    );
                    return;
                  }

                  OrderData.orders.add(
                    Order.fromCart(
                      cart: CartData.cart,
                      name: nameCtrl.text,
                      address: addressCtrl.text,
                      payment: payment,
                    ),
                  );

                  CartData.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pesanan berhasil dibuat"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
