import 'package:flutter/material.dart';

class PetService {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String imageEmoji;

  const PetService({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.imageEmoji,
  });

  static const List<PetService> services = [
    PetService(
      id: '1',
      title: 'Bathing & Drying',
      description: 'Bath with premium shampoo & towel drying',
      icon: Icons.water_drop,
      color: Color(0xFF6C63FF),
      imageEmoji: '🛁',
    ),
    PetService(
      id: '2',
      title: 'Dog Sitting',
      description: 'Daily care, feeding & outdoor activities',
      icon: Icons.chair,
      color: Color(0xFF4ECDC4),
      imageEmoji: '🐕',
    ),
    PetService(
      id: '3',
      title: 'Hair Styling',
      description: 'Professional trim & style consultation',
      icon: Icons.content_cut,
      color: Color(0xFFFF9671),
      imageEmoji: '✂️',
    ),
    PetService(
      id: '4',
      title: 'Teeth Cleaning',
      description: 'Professional ultrasonic cleaning & polishing',
      icon: Icons.cleaning_services,
      color: Color(0xFF95E1D3),
      imageEmoji: '🦷',
    ),
    PetService(
      id: '5',
      title: 'Nail Trimming',
      description: 'Gentle nail clipping & filing services',
      icon: Icons.cut,
      color: Color(0xFFFDB44B),
      imageEmoji: '💅',
    ),
    PetService(
      id: '6',
      title: 'Flea Control Solutions',
      description: 'Safe & effective flea & tick treatments',
      icon: Icons.bug_report,
      color: Color(0xFFFF6B6B),
      imageEmoji: '🐞',
    ),
  ];
}

class ServiceCategory {
  final String id;
  final String name;
  final String imageEmoji;
  final String description;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.imageEmoji,
    required this.description,
  });

  static const List<ServiceCategory> categories = [
    ServiceCategory(
      id: 'grooming',
      name: 'Pet Grooming',
      imageEmoji: '✂️',
      description: 'Professional grooming services',
    ),
    ServiceCategory(
      id: 'dog-grooming',
      name: 'Dog Grooming',
      imageEmoji: '🐕',
      description: 'Specialized dog care',
    ),
    ServiceCategory(
      id: 'spa',
      name: 'Pet Grooming',
      imageEmoji: '🛁',
      description: 'Spa & wellness treatments',
    ),
    ServiceCategory(
      id: 'bird',
      name: 'Bird Grooming',
      imageEmoji: '🦜',
      description: 'Bird care services',
    ),
    ServiceCategory(
      id: 'turtle',
      name: 'Turtle Grooming',
      imageEmoji: '🐢',
      description: 'Reptile care',
    ),
    ServiceCategory(
      id: 'rabbit',
      name: 'Rabbit Grooming',
      imageEmoji: '🐰',
      description: 'Small animal care',
    ),
  ];
}
