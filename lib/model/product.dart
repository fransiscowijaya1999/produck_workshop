class Product {
  final int id;
  final String name;
  final double price;
  final double cost;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.cost
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'price': double price,
        'cost': double cost
      } => Product(
        id: id,
        name: name,
        price: price,
        cost: cost
      ),
      _ => throw const FormatException('Failed to load product from database')
    };
  }

  static List<Product> fromJsonList(List<dynamic> productsJson) {
    List<Product> products = [];

    for (final product in productsJson) {
      products.add(Product.fromJson(product));
    }

    print(products);

    return products;
  }
}