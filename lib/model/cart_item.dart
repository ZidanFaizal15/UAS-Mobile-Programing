import 'food.dart';

class CartItem {
  final Food food;
  int qty;
  String option;

  CartItem({
    required this.food,
    required this.option,
    this.qty = 1,
  });

  int get subtotal => food.price * qty;

  CartItem copy() {
    return CartItem(
      food: food,
      option: option,
      qty: qty,
    );
  }
}
