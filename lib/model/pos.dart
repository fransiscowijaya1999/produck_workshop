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