import 'package:hive/hive.dart';
import '../model/order.dart';

class OrderHive {
  static final box = Hive.box('orders');

  static void add(Order order) {
    box.add(order.toMap());
  }

  static List<Map> getAll() {
    return box.values.cast<Map>().toList();
  }

  static void delete(int index) {
    box.deleteAt(index);
  }
}
