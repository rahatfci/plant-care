class Cart {
  final String id;
  final String productId;
  final int quantity;
  final String userId;

  Cart(
      {required this.id,
      required this.productId,
      required this.quantity,
      required this.userId});

  Map<String, dynamic> toJson(Cart cart) {
    return {
      'id': cart.id,
      'productId': cart.productId,
      'quantity': cart.quantity,
      'userId': cart.userId,
    };
  }

  static Cart fromJson(data) {
    return Cart(
        id: data['id'],
        productId: data['productId'],
        quantity: data['quantity'],
        userId: data['userId']);
  }
}
