class UserCardModel {
  final String id;
  final String name;
  final int age;
  final String job;
  final String imageUrl;
  final String distance;

  UserCardModel({
    required this.id,
    required this.name,
    required this.age,
    required this.job,
    required this.imageUrl,
    this.distance = '1 km',
  });
}
