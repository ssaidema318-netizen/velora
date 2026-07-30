class ProductItemModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final String categoryName;

  final bool isFeatured;
  final bool isFlashSale;
  final bool isRecommended;

  final bool inStock;
  final int stock;

  final double? oldPrice;
  final int? discount;

  const ProductItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.categoryName,

    this.isFeatured = false,
    this.isFlashSale = false,
    this.isRecommended = false,

    this.inStock = true,
    this.stock = 0,

    this.oldPrice,
    this.discount,
  });
}

const List<ProductItemModel> dummyProducts = [
  ProductItemModel(
    id: '1',
    name: 'Apple Watch Ultra 2',
    price: 799.0,
    oldPrice: 899.0,
    discount: 11,
    imageUrl: 'assets/images/apple_watch_ultra_2.webp',
    rating: 4.9,
    reviewCount: 1824,
    description: 'Premium smartwatch with advanced health tracking, GPS, and long battery life.',
    categoryName: 'Wearables',
    isFeatured: true,
    isRecommended: true,
    inStock: true,
    stock: 15,
  ),

  ProductItemModel(
    id: '2',
    name: 'Galaxy Watch Ultra',
    price: 699.0,
    imageUrl: 'assets/images/galaxy_watch_ultra.jfif',
    rating: 4.8,
    reviewCount: 943,
    description: 'Powerful smartwatch with AI features and premium titanium design.',
    categoryName: 'Wearables',
    isRecommended: true,
    inStock: true,
    stock: 20,
  ),

  ProductItemModel(
    id: '3',
    name: 'Sony WH-1000XM6',
    price: 399.0,
    oldPrice: 449.0,
    discount: 11,
    imageUrl: 'assets/images/sony_wH-1000XM6.jfif',
    rating: 4.9,
    reviewCount: 2310,
    description: 'Industry-leading noise cancellation with exceptional sound quality.',
    categoryName: 'Audio',
    isFeatured: true,
    inStock: true,
    stock: 12,
  ),

  ProductItemModel(
    id: '4',
    name: 'AirPods Pro 3',
    price: 249.0,
    imageUrl: 'assets/images/airpods_pro 3.jfif',
    rating: 4.8,
    reviewCount: 1750,
    description: 'Spatial audio, adaptive transparency, and USB-C charging.',
    categoryName: 'Audio',
    isRecommended: true,
    inStock: true,
    stock: 25,
  ),

  ProductItemModel(
    id: '5',
    name: 'Nothing Ear (3)',
    price: 149.0,
    imageUrl: 'assets/images/nothing_Ear(3).jfif',
    rating: 4.7,
    reviewCount: 618,
    description: 'Minimal design with premium sound and ANC.',
    categoryName: 'Audio',
    inStock: true,
    stock: 18,
  ),

  ProductItemModel(
    id: '6',
    name: 'iPhone 17 Pro',
    price: 1299.0,
    imageUrl: 'assets/images/iPhone_17_pro.jfif',
    rating: 5.0,
    reviewCount: 310,
    description: 'Apple flagship with the latest A-series chip and pro camera system.',
    categoryName: 'Phones',
    isFeatured: true,
    isRecommended: true,
    inStock: true,
    stock: 10,
  ),

  ProductItemModel(
    id: '7',
    name: 'Galaxy S26 Ultra',
    price: 1199.0,
    oldPrice: 1299.0,
    discount: 8,
    imageUrl: 'assets/images/galaxy_s26_ultra.jfif',
    rating: 4.9,
    reviewCount: 812,
    description: 'Samsung flagship with AI camera and S Pen.',
    categoryName: 'Phones',
    isFlashSale: true,
    inStock: true,
    stock: 8,
  ),

  ProductItemModel(
    id: '8',
    name: 'Google Pixel 11 Pro',
    price: 999.0,
    imageUrl: 'assets/images/google_pixel_11_pro.jfif',
    rating: 4.8,
    reviewCount: 542,
    description: 'Pure Android experience with the best AI photography.',
    categoryName: 'Phones',
    inStock: true,
    stock: 14,
  ),

  ProductItemModel(
    id: '9',
    name: 'MacBook Pro M6',
    price: 2499.0,
    imageUrl: 'assets/images/macbook_pro_m6.jfif',
    rating: 5.0,
    reviewCount: 267,
    description: 'Ultimate performance for creators and professionals.',
    categoryName: 'Laptops',
    isFeatured: true,
    inStock: true,
    stock: 6,
  ),

  ProductItemModel(
    id: '10',
    name: 'ASUS ROG Zephyrus G16',
    price: 2199.0,
    imageUrl: 'assets/images/asus_rog_zephyrus_g16.jfif',
    rating: 4.9,
    reviewCount: 731,
    description: 'Premium gaming laptop with RTX graphics and OLED display.',
    categoryName: 'Laptops',
    isRecommended: true,
    inStock: true,
    stock: 9,
  ),

  ProductItemModel(
    id: '11',
    name: 'Logitech MX Master 4',
    price: 129.0,
    imageUrl: 'assets/images/logitech_mx_master_4.jfif',
    rating: 4.9,
    reviewCount: 1987,
    description: 'The ultimate productivity mouse for professionals.',
    categoryName: 'Accessories',
    inStock: true,
    stock: 30,
  ),

  ProductItemModel(
    id: '12',
    name: 'Keychron K8 Pro',
    price: 109.0,
    imageUrl: 'assets/images/keychron_k8_pro.jfif',
    rating: 4.8,
    reviewCount: 902,
    description: 'Wireless mechanical keyboard with hot-swappable switches.',
    categoryName: 'Accessories',
    isFlashSale: true,
    inStock: true,
    stock: 22,
  ),

  ProductItemModel(
    id: '13',
    name: 'DJI Mini 5 Pro',
    price: 999.0,
    imageUrl: 'assets/images/dJI_mini_5_pro.jfif',
    rating: 4.9,
    reviewCount: 411,
    description: 'Compact drone with 4K HDR camera and obstacle avoidance.',
    categoryName: 'Drones',
    isFeatured: true,
    inStock: true,
    stock: 7,
  ),

  ProductItemModel(
    id: '14',
    name: 'Anker Prime Power Bank',
    price: 149.0,
    imageUrl: 'assets/images/anker_prime_power_bank.jfif',
    rating: 4.8,
    reviewCount: 1245,
    description: 'High-capacity fast charging power bank with USB-C.',
    categoryName: 'Accessories',
    inStock: true,
    stock: 35,
  ),

  ProductItemModel(
    id: '15',
    name: 'Kindle Paperwhite',
    price: 179.0,
    imageUrl: 'assets/images/kindle_paperwhite.jfif',
    rating: 4.9,
    reviewCount: 3289,
    description: 'Read comfortably anywhere with a glare-free display.',
    categoryName: 'Tablets',
    isRecommended: true,
    inStock: true,
    stock: 16,
  ),
];