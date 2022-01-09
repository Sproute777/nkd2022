import 'package:hive/hive.dart';
import '../models/models.dart';

class HiveMixinRepository {
  Future<Box<Card>> get _cardBox async => await Hive.openBox<Card>('c_box');

  Future<List<Card>>? fetchHiveCards() async {
    var box = await _cardBox;
    final cards = box.values.toList();
    return cards;
  }

  Future<void> addHiveCards(List<Card> cards) async {
    var box = await _cardBox;
    for (var card in cards) {
      box.put(card.id, card);
    }
    return;
  }

  Future<void> saveHiveCard(Card card) async {
    var box = await _cardBox;
    var future = box.put(card.id, card);
    return future;
  }

  Future<int> clearHiveCards() async {
    var box = await _cardBox;
    var future = await box.clear();
    return future;
  }

  Future<void> deleteHiveCard(int id) async {
    var box = await _cardBox;
    var future = box.delete(id);
    return future;
  }
}
