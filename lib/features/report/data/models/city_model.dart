import '../../domain/entities/city_entity.dart';
import 'country_model.dart';

class CityModel extends CityEntity {
  CityModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.country,
    required super.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['_id'] as String,
      nameEn: json['nameEn'] as String,
      nameAr: json['nameAr'] as String,
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
