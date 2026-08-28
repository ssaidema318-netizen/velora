class ApiPaths {
  static String user(String uid)=>'users/$uid';
  static String cartItem(String uid,String cartItemId)=>'users/$uid/cart/$cartItemId/';
  static String products()=>'products';
  static String announcements()=>'announcements';
  static String category(String id)=>'categories/$id';
  static String categories(String id)=>'categories/$id';

  static String product(String productId)=>'products/$productId';
}