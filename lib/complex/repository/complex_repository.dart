import 'package:hive/hive.dart';

import 'hive_mixin_repository.dart';
import '../complex.dart';

class ComplexRepository with HiveMixinRepository {
  ComplexRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();
  final ApiClient _apiClient;

  Future<String>? get _getToken async => await Hive.box('api_box').get('token');

  Future<List<Item>> getItems() async {
    final token = await _getToken;
    if (token != null) {
      final response = await _apiClient.get(kcards, token: token);
      var data = response.data as List;
      var items = data.map((element) {
        var item = Item.fromJson(element);
        return item;
      }).toList();
      return items;
    }

    return <Item>[];
  }

  Future<dynamic>? createItem(String row, String text) async {
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
      return response.data;
    }
    return null;
  }

  Future<dynamic>? updateItem(
      {required int id,
      required String row,
      required int seqNum,
      required String text}) async {
    final token = await _getToken;
    if (token != null) {
      final response = await _apiClient.update(
        "$kcards$id/",
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

  Future<int?> deleteItem(int id) async {
    final token = await _getToken;
    if (token != null) {
      final response = await _apiClient.delete('$kcards$id/', token: token);
      return response.statusCode;
    }
    return null;
  }
}
