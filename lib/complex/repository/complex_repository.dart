import 'package:hive/hive.dart';

import 'hive_mixin_repository.dart';
import '../complex.dart';

class ComplexRepository with HiveMixinRepository {
  ComplexRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();
  final ApiClient _apiClient;

  Future<String>? get _getToken async => await Hive.box('api_box').get('token');

  Future<List<Card>> getCards() async {
    final token = await _getToken;
    if (token != null) {
      final response = await _apiClient.get(kcards, token: token);
      var data = response.data as List;
      var cards = data.map((element) {
        var card = Card.fromJson(element);
        return card;
      }).toList();
      return cards;
    }

    return <Card>[];
  }

  Future<dynamic>? createCard(int row, String text) async {
    final token = await _getToken;
    if (token != null) {
      final response = await _apiClient.post(
        kcards,
        token: token,
        data: {
          'row': row,
          'text': text,
        },
      );
      return response;
    }
    return null;
  }

  Future<dynamic>? updateCard(int id, int row, int seqNum, String text) async {
    final token = await _getToken;
    if (token != null) {
      final response = await _apiClient.post(
        '$kcards$id/',
        token: token,
        data: {
          'seq_num': seqNum,
          'row': row,
          'text': text,
        },
      );
      return response.data;
    }
    return null;
  }

  Future<dynamic>? deleteCard(int id) async {
    final token = await _getToken;
    if (token != null) {
      final response = await _apiClient.delete('$kcards$id/', token: token);
      return response.data;
    }
    return null;
  }
}
