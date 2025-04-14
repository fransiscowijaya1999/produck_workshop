import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:produck_workshop/http/client.dart';
import 'package:produck_workshop/model/pos.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:produck_workshop/schema/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosService {
  static Future<void> submitOrder(List<Order> orders) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final int? posId = await prefs.getInt(prefsApi['POS_ID']!);
    final String apiToken = await prefs.getString(prefsApi['API_TOKEN']!) ?? '';
    final jwt = JWT.decode(apiToken);
    final int userId = int.parse(jwt.payload['jti']);
    
    final List<TransactionItem> transactionItems = [];
    final transaction = Transaction(
      posId: posId!,
      userId: userId,
      createdAt: DateTime.now(),
      items: transactionItems
    );

    // await dio
    //   .post('/orders', queryParameters: {
    //     'posId': transaction.posId,
    //     'createdAt': transaction.createdAt.toString(),
    //     'userId': userId,
    //     'items': _orderItemToJson(transaction.items)
    //   });
  }

  static List<Map<String, dynamic>> _orderItemToJson(List<TransactionItem> items) {
    return items.map((item) => {
      'product': {
        'id': item.productId
      },
      'cost': item.cost,
      'price': item.price,
      'qty': item.qty
    }).toList();
  }
  
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