// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddToCartModel {
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'productId': productId,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'rating': rating,
      'reviewCount': reviewCount,
      'stock': stock,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      name: map['name'] as String,
      productId: map['productId'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      rating: map['rating'] as double,
      reviewCount: map['reviewCount'] as int,
      stock: map['stock'] as int,
    );
  }


}

List<AddToCartModel> dummyCart =[];
