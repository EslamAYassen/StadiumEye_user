import '../../domain/entities/stadium_list_entity.dart';

class StadiumListModel extends StadiumListEntity {
  StadiumListModel({
    required super.id,
    required super.stadiumName,
    required super.cityId,
    required super.stadiumImages,
    required super.capacity,
    required super.locationLink,
    required super.createdAt,
  });

  factory StadiumListModel.fromJson(Map<String, dynamic> json) {
    return StadiumListModel(
      id: json['_id'] as String,
      stadiumName: json['stadiumName'] as String,
      //TODO: change this when u can
      cityId: json['city']["_id"] as String,
      stadiumImages: (json['stadiumImages'] as List?)?.cast<String>() ?? [],
      capacity: json['capacity'] as int,
      locationLink: json['locationLink'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
