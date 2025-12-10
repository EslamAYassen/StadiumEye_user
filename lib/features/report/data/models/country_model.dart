import '../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['_id'] as String,
      nameEn: json['nameEn'] as String,
      nameAr: json['nameAr'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
