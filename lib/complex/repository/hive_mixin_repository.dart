import 'package:hive/hive.dart';
import '../models/models.dart';

class HiveMixinRepository {
  Future<Box<Item>> get _cardBox async => await Hive.openBox<Item>('itemz_box');

  Future<List<Item>>? fetchAllHive() async {
    var box = await _cardBox;
    final cards = box.values.toList();
    return cards;
  }

  Future<void> addAllHive(List<Item> items) async {
    var box = await _cardBox;
    for (var item in items) {
      box.put(item.id, item);
    }
    return;
  }

  Future<void> addOneHive(Item item) async {
    var box = await _cardBox;
    var future = box.put(item.id, item);
    return future;
  }

  Future<int> clearHiveBox() async {
    var box = await _cardBox;
    var future = await box.clear();
    return future;
  }

  Future<void> deleteOneHive(int id) async {
    var box = await _cardBox;
    var future = box.delete(id);
    return future;
  }
}
