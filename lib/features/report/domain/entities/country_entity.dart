class CountryEntity {
  final String id;
  final String nameEn;
  final String nameAr;
  final DateTime createdAt;
  final DateTime updatedAt;

  CountryEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.createdAt,
    required this.updatedAt,
  });
}
