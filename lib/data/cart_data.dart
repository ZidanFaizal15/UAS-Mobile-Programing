import '../model/cart_item.dart';
import '../model/food.dart';

class CartData {
  static final List<CartItem> cart = [];

  static void add(Food food, String option) {
    final index = cart.indexWhere(
          (item) =>
      item.food.name == food.name && item.option == option,
    );

    if (index >= 0) {
      cart[index].qty++;
    } else {
      cart.add(
        CartItem(
          food: food,
          option: option,
          qty: 1,
        ),
      );
    }
  }

  static void remove(CartItem item) {
    cart.remove(item);
  }

  static void clear() {
    cart.clear();
  }

  static int get total {
    return cart.fold(
      0,
          (sum, item) => sum + item.subtotal,
    );
  }
}
