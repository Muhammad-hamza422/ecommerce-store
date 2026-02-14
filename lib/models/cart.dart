class CartItem {
  final int productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: (json['productId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  CartItem copyWith({int? quantity}) {
    return CartItem(
      productId: productId,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Cart {
  final int id;
  final int userId;
  final DateTime? date;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    this.date,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      items: (json['products'] as List<dynamic>? ?? [])
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}


