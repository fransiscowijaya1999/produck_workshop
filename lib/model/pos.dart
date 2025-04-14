class Pos {
  final int id;
  final String name;

  const Pos({
    required this.id,
    required this.name,
  });

  factory Pos.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
      } => Pos(
        id: id,
        name: name,
      ),
      _ => throw const FormatException('Failed to load pos from database')
    };
  }

  static List<Pos> fromJsonList(List<dynamic> posJson) {
    List<Pos> posList = [];

    for (final pos in posJson) {
      posList.add(Pos.fromJson(pos));
    }

    return posList;
  }
}

class Transaction {
  final int posId;
  final int userId;
  final DateTime createdAt;
  final List<TransactionItem> items;

  const Transaction({
    required this.posId,
    required this.userId,
    required this.createdAt,
    this.items = const [],
  });
}

class TransactionItem {
  final double price;
  final double cost;
  final int qty;
  final int productId;

  const TransactionItem({
    required this.price,
    required this.cost,
    required this.qty,
    required this.productId
  });
}