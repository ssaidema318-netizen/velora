class AddToCartModel{
  final String name;
  final String productId;
  final String imageUrl;
  final int price;
  final int quantity;
  final double rating;
  final int reviewCount;


  AddToCartModel ({required this.productId, required this.quantity, required this.imageUrl, required this.price, required this.name, required this.rating, required this.reviewCount});

  AddToCartModel copyWith({
    String? name,
    String? productId,
    String? imageUrl,
    int? price,
    int? quantity,
    double? rating,
    int? reviewCount,
  }) {
    return AddToCartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}

List<AddToCartModel> dummyCart =[];
