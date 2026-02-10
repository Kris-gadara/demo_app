import 'pet_category.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final PetType category;
  final double rating;
  final String weight;
  final bool isTrending;
  final List<String> features;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.rating = 4.0,
    this.weight = '',
    this.isTrending = false,
    this.features = const [],
  });

  static const List<Product> sampleProducts = [
    Product(
      id: '1',
      name: 'Symply Dog Adult Chicken',
      description: 'With Rice & Vegetables',
      price: 1.99,
      imageUrl: '🦴',
      category: PetType.dog,
      rating: 4.0,
      weight: '395g',
      isTrending: true,
      features: [
        '73% Meat Content',
        'No artificial preservatives',
        'Rich in protein',
        'Healthy digestion'
      ],
    ),
    Product(
      id: '2',
      name: 'Canagan Dental Care',
      description: 'Get Up To 40% OFF',
      price: 29.99,
      imageUrl: '🦷',
      category: PetType.dog,
      rating: 4.5,
      weight: '1.5kg',
      isTrending: true,
      features: ['Dental health', 'Fresh breath', 'Strong teeth'],
    ),
    Product(
      id: '3',
      name: 'Premium Cat Food',
      description: 'Chicken & Ocean Fish',
      price: 12.99,
      imageUrl: '🐟',
      category: PetType.cat,
      rating: 4.2,
      weight: '1kg',
      isTrending: true,
      features: ['High protein', 'Omega-3 enriched', 'Shiny coat'],
    ),
    Product(
      id: '4',
      name: 'Eco-friendly Toys',
      description: 'Your dog will love',
      price: 8.99,
      imageUrl: '🎾',
      category: PetType.dog,
      rating: 4.8,
      weight: '',
      isTrending: false,
      features: ['Sustainable materials', 'Safe for pets', 'Durable'],
    ),
    Product(
      id: '5',
      name: 'Bird Seed Mix',
      description: 'Premium blend for all birds',
      price: 5.99,
      imageUrl: '🌾',
      category: PetType.bird,
      rating: 4.3,
      weight: '500g',
      features: ['Nutrient rich', 'No fillers', 'Fresh ingredients'],
    ),
    Product(
      id: '6',
      name: 'Small Animal Pellets',
      description: 'For rabbits, guinea pigs',
      price: 7.49,
      imageUrl: '🥕',
      category: PetType.smallAnimal,
      rating: 4.1,
      weight: '800g',
      features: ['High fiber', 'Vitamin enriched', 'Digestive health'],
    ),
  ];
}
