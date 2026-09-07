// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

class CategoriesHomeModel {
  final String id;
  final String title;
  final String imageUrl;
  final Color color;

  const CategoriesHomeModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'imageUrl': imageUrl, 'color': color.toARGB32()};
  }

  factory CategoriesHomeModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return CategoriesHomeModel(
      id: documentId,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      color: Color(map['color'] as int),
    );
  }
}

const List<CategoriesHomeModel> dummyCategories = [
  CategoriesHomeModel(
    id: '1',
    title: 'Phones',
    color: Color(0xFF3B82F6),
    imageUrl:
        'https://ar.pngtree.com/freepng/modern-smartphone-with-large-screen---mobile-phone-clipart_21183194.html',
  ),
  CategoriesHomeModel(
    id: '2',
    title: 'Laptops',
    color: Color(0xFF8B5CF6),
    imageUrl:
        'https://images.pexels.com/photos/10948208/pexels-photo-10948208.jpeg',
  ),
  CategoriesHomeModel(
    id: '3',
    title: 'Audio',
    color: Color(0xFFF97316),
    imageUrl:
        'https://images.pexels.com/photos/5269752/pexels-photo-5269752.jpeg',
  ),
  CategoriesHomeModel(
    id: '4',
    title: 'Wearables',
    color: Color(0xFF10B981),
    imageUrl:
        'https://images.pexels.com/photos/18662969/pexels-photo-18662969.jpeg',
  ),
  CategoriesHomeModel(
    id: '5',
    title: 'Gaming',
    color: Color(0xFFEF4444),
    imageUrl:
        'https://images.pexels.com/photos/21952577/pexels-photo-21952577.jpeg',
  ),
  CategoriesHomeModel(
    id: '6',
    title: 'Accessories',
    color: Color(0xFFF59E0B),
    imageUrl:
        'https://images.pexels.com/photos/7172690/pexels-photo-7172690.jpeg',
  ),
  CategoriesHomeModel(
    id: '7',
    title: 'Drones',
    color: Color(0xFF06B6D4),
    imageUrl:
        'https://images.pexels.com/photos/32674152/pexels-photo-32674152.jpeg',
  ),
  CategoriesHomeModel(
    id: '8',
    title: 'Tablets',
    color: Color(0xFF6366F1),
    imageUrl:
        'https://images.pexels.com/photos/16150335/pexels-photo-16150335.jpeg',
  ),
];
