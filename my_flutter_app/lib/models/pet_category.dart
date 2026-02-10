import 'package:flutter/material.dart';

enum PetType {
  all,
  dog,
  cat,
  bird,
  smallAnimal,
}

class PetCategory {
  final String id;
  final String name;
  final IconData icon;
  final PetType type;
  final Color color;

  const PetCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.color,
  });

  static const List<PetCategory> categories = [
    PetCategory(
      id: 'all',
      name: 'All',
      icon: Icons.pets,
      type: PetType.all,
      color: Color(0xFFFF6B6B),
    ),
    PetCategory(
      id: 'dog',
      name: 'Dog',
      icon: Icons.pets,
      type: PetType.dog,
      color: Color(0xFFFF9671),
    ),
    PetCategory(
      id: 'cat',
      name: 'Cat',
      icon: Icons.pets,
      type: PetType.cat,
      color: Color(0xFF4ECDC4),
    ),
    PetCategory(
      id: 'bird',
      name: 'Bird',
      icon: Icons.flutter_dash,
      type: PetType.bird,
      color: Color(0xFF95E1D3),
    ),
    PetCategory(
      id: 'small',
      name: 'Small Animal',
      icon: Icons.cruelty_free,
      type: PetType.smallAnimal,
      color: Color(0xFFFDB44B),
    ),
  ];
}
