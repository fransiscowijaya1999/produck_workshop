import 'package:produck_workshop/http/client.dart';
import 'package:produck_workshop/model/pos.dart';

class PosService {
  static Future<List<Pos>> filterPos(String keyword, int limit) async {
    try {
      final response = await dio
        .get('/pos', queryParameters: {
          'keyword': keyword,
          'pageSize': limit
        });

      if (response.statusCode == 200) {
        if (response.data['payload'] != null) {
          return Pos.fromJsonList(response.data['payload']);
        } else {
          return [];
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthenticated');
      } else {
        throw Exception('Unknown Error - Failed to load pos');
      }
    } catch (error) {
      rethrow;
    }
  }
}