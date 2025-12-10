import 'country_entity.dart';

class CityEntity {
  final String id;
  final String nameEn;
  final String nameAr;
  final CountryEntity country;
  final DateTime createdAt;

  CityEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.country,
    required this.createdAt,
  });
}
