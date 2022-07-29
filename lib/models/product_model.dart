class Product {
  final String id;
  final String name;
  final String imgPath;
  final String description;
  final int quantity;
  final String discount;
  final String price;
  final String imgName;
  final String category;

  Product(
      {required this.id,
      required this.name,
      required this.imgPath,
      required this.description,
      required this.quantity,
      required this.discount,
      required this.price,
      required this.imgName,
      required this.category});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imgPath': imgPath,
      'description': description,
      'quantity': quantity,
      'discount': discount,
      'price': price,
      'imgName': imgName,
      'category': category
    };
  }

  static Product fromJson(data) {
    return Product(
        id: data['id'],
        name: data['name'],
        imgPath: data['imgPath'],
        description: data['description'],
        quantity: data['quantity'],
        discount: data['discount'],
        price: data['price'],
        imgName: data['imgName'],
        category: data['category']);
  }
}
