import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CategoriesHomeModel {
  final String id;
  final String title;
  final dynamic icon;
  final Color color;

  const CategoriesHomeModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
  });
}

const List<CategoriesHomeModel> dummyCategories = [
  CategoriesHomeModel(
    id: '1',
    title: 'Phones',
    icon: HugeIcons.strokeRoundedSmartPhone01,
    color: Color(0xFF3B82F6),
  ),

  CategoriesHomeModel(
    id: '2',
    title: 'Laptops',
    icon: HugeIcons.strokeRoundedLaptop,
    color: Color(0xFF8B5CF6),
  ),

  CategoriesHomeModel(
    id: '3',
    title: 'Audio',
    icon: HugeIcons.strokeRoundedHeadphones,
    color: Color(0xFFF97316),
  ),

  CategoriesHomeModel(
    id: '4',
    title: 'Wearables',
    icon: HugeIcons.strokeRoundedSmartWatch01,
    color: Color(0xFF10B981),
  ),

  CategoriesHomeModel(
    id: '5',
    title: 'Gaming',
    icon: HugeIcons.strokeRoundedGameController02,
    color: Color(0xFFEF4444),
  ),

  CategoriesHomeModel(
    id: '6',
    title: 'Accessories',
    icon: HugeIcons.strokeRoundedMouseLeftClick01,
    color: Color(0xFFF59E0B),
  ),

  CategoriesHomeModel(
    id: '7',
    title: 'Drones',
    icon: HugeIcons.strokeRoundedDrone,
    color: Color(0xFF06B6D4),
  ),

  CategoriesHomeModel(
    id: '8',
    title: 'Tablets',
    icon: HugeIcons.strokeRoundedTablet01,
    color: Color(0xFF6366F1),
  ),
];