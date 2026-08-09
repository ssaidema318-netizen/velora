class AddToCartModel{
  final String name;
  final String productId;
  final String imageUrl;
  final int price;
  final int quantity;
  final double rating;
  final int reviewCount;
  final int stock;


  AddToCartModel ({required this.productId, required this.quantity, required this.imageUrl, required this.price, required this.name, required this.rating, required this.reviewCount, required this.stock});

  AddToCartModel copyWith({
    String? name,
    String? productId,
    String? imageUrl,
    int? price,
    int? quantity,
    double? rating,
    int? reviewCount,
    int? stock,
  }) {
    return AddToCartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount, 
      stock: stock ?? this.stock,
    );
  }
  
 int get totalPrice => quantity * price;
}

List<AddToCartModel> dummyCart =[];
