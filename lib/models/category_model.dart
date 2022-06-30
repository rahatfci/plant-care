class Category {
  final String id;
  final String name;
  final String imgPath;
  final String imgName;
  final int color;

  Category(
      {required this.id,
      required this.name,
      required this.imgPath,
      required this.imgName,
      required this.color});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imgPath': imgPath,
      'imgName': imgName,
      'color': color
    };
  }

  static Category fromJson(data) {
    return Category(
        id: data['id'],
        name: data['name'],
        imgPath: data['imgPath'],
        imgName: data['imgName'],
        color: data['color']);
  }
}
