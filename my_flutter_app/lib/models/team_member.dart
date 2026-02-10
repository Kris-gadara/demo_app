class TeamMember {
  final String id;
  final String name;
  final String role;
  final String imageEmoji;
  final double rating;
  final int experience;

  const TeamMember({
    required this.id,
    required this.name,
    required this.role,
    required this.imageEmoji,
    this.rating = 5.0,
    this.experience = 1,
  });

  static const List<TeamMember> team = [
    TeamMember(
      id: '1',
      name: 'John Beves',
      role: 'Pet Expert',
      imageEmoji: '👨',
      rating: 5.0,
      experience: 5,
    ),
    TeamMember(
      id: '2',
      name: 'Jessica Lauren',
      role: 'Groomer',
      imageEmoji: '👩',
      rating: 4.9,
      experience: 4,
    ),
    TeamMember(
      id: '3',
      name: 'Jenny Wilson',
      role: 'Pet Expert',
      imageEmoji: '👩‍⚕️',
      rating: 4.8,
      experience: 3,
    ),
    TeamMember(
      id: '4',
      name: 'Darlet Thomas',
      role: 'Pet Expert',
      imageEmoji: '👨‍⚕️',
      rating: 5.0,
      experience: 6,
    ),
    TeamMember(
      id: '5',
      name: 'Olivia Grace',
      role: 'Pet Stylist',
      imageEmoji: '👩‍🦰',
      rating: 4.7,
      experience: 2,
    ),
    TeamMember(
      id: '6',
      name: 'Ethan Parker',
      role: 'Veterinarian',
      imageEmoji: '👨‍⚕️',
      rating: 5.0,
      experience: 8,
    ),
    TeamMember(
      id: '7',
      name: 'Sophia Horvath',
      role: 'Pet Expert',
      imageEmoji: '👩‍🔬',
      rating: 4.9,
      experience: 4,
    ),
    TeamMember(
      id: '8',
      name: 'Liam Carter',
      role: 'Dog Trainer',
      imageEmoji: '👨‍🏫',
      rating: 4.8,
      experience: 5,
    ),
  ];
}
