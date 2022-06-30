class Seller {
  final String id;
  final String name;
  final String imgPath;
  final String description;

  Seller({
    required this.id,
    required this.name,
    required this.imgPath,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imgPath': imgPath,
      'description': description,
    };
  }

  static Seller fromJson(data) {
    return Seller(
      id: data['id'],
      name: data['name'],
      imgPath: data['imgPath'],
      description: data['description'],
    );
  }
}
