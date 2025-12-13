class StadiumListEntity {
  final String id;
  final String stadiumName;
  final String cityId;
  final List<String> stadiumImages;
  final int capacity;
  final String locationLink;
  final DateTime createdAt;

  StadiumListEntity({
    required this.id,
    required this.stadiumName,
    required this.cityId,
    required this.stadiumImages,
    required this.capacity,
    required this.locationLink,
    required this.createdAt,
  });
}
