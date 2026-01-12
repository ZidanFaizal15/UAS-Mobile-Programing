import 'package:flutter/material.dart';
import 'data/order_data.dart';
import 'model/order.dart';
import 'data/cart_data.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesanan")),
      body: OrderData.orders.isEmpty
          ? const Center(child: Text("Belum ada pesanan"))
          : ListView.builder(
        itemCount: OrderData.orders.length,
        itemBuilder: (context, index) {
          final order = OrderData.orders[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              title: Text(
                "Rp ${order.total}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Atas nama: ${order.name}"),
                  Text("Status: ${order.status}"),
                ],
              ),
              trailing:
              const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        OrderDetailPage(order: order),
                  ),
                );
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}

/* ===========================
   DETAIL PESANAN
   =========================== */
class OrderDetailPage extends StatefulWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pesanan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama: ${order.name}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Alamat: ${order.address}"),
            Text("Pembayaran: ${order.payment}"),
            Text("Status: ${order.status}"),

            const Divider(height: 32),

            const Text(
              "Daftar Makanan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ...order.items.map(
                  (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "- ${item.food.name} x${item.qty} (Rp ${item.subtotal})",
                ),
              ),
            ),

            const Spacer(),

            /// ===== TOMBOL AKSI (RESPONSIF & CENTER) =====
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: order.status == "Diproses"
                        ? () {
                      setState(() {
                        order.status = "Dibatalkan";
                      });
                    }
                        : null,
                    child: const Text("Batalkan"),
                  ),
                ),

                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      CartData.cart.clear();
                      CartData.cart.addAll(order.items);
                      Navigator.pop(context);
                    },
                    child: const Text("Pesan Ulang"),
                  ),
                ),

                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      OrderData.orders.remove(order);
                      Navigator.pop(context);
                    },
                    child: const Text("Hapus"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

