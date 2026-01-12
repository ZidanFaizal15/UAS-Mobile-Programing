import 'cart_item.dart';

class Order {
  List<CartItem> items;
  String status;
  String name;
  String address;
  String payment;
  DateTime time;

  Order({
    required this.items,
    required this.name,
    required this.address,
    required this.payment,
    this.status = "Diproses",
    required this.time,
  });

  factory Order.fromCart({
    required List<CartItem> cart,
    required String name,
    required String address,
    required String payment,
  }) {
    return Order(
      items: cart.map((item) => item.copy()).toList(), // 🔥 FIX UTAMA
      name: name,
      address: address,
      payment: payment,
      status: "Diproses",
      time: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'payment': payment,
      'status': status,
      'total': total,
    };
  }


  int get total =>
      items.fold(0, (sum, item) => sum + item.subtotal);
}
