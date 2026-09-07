class ApiPaths {
  static String user(String uid)=>'users/$uid';
  static String cartItem(String uid,String cartItemId)=>'users/$uid/cart/$cartItemId';
  static String cartItems(String uid)=>'users/$uid/cart/';
  static String paymentCard(String uid,String paymentId)=>'users/$uid/payments/$paymentId';
  static String paymentCards(String uid)=>'users/$uid/payments/';
  static String address(String uid,String addressId)=>'users/$uid/addresses/$addressId';
  static String addresses(String uid)=>'users/$uid/addresses';
  static String favoriteProduct(String uid,String favoriteId)=>'users/$uid/favorites/$favoriteId';
  static String favoriteProducts(String uid)=>'users/$uid/favorites';
  static String products()=>'products';
  static String announcements()=>'announcements';
  static String category()=>'categories';
  static String categories(String id)=>'categories/$id';

  static String product(String productId)=>'products/$productId';
}