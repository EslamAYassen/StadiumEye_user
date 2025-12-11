import '../../domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.countryId,
    required super.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['_id'] as String,
      nameEn: json['nameEn'] as String,
      nameAr: json['nameAr'] as String,
      countryId: json['country']['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
