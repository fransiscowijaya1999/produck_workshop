import 'package:produck_workshop/http/client.dart';
import 'package:produck_workshop/model/product.dart';

class ProductService {
  static Future<List<Product>> filterProductLimited(String keyword, int limit) async {
    try {
      final response = await dio
        .get('/products', queryParameters: {
          'keyword': keyword,
          'pageSize': limit
        });

      if (response.statusCode == 200) {
        return Product.fromJsonList(response.data['payload']);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthenticated');
      } else {
        throw Exception('Unknown Error - Failed to load product');
      }
    } catch (error) {
      rethrow;
    }
  }
}