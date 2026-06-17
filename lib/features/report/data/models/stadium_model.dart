import '../../domain/entities/stadium_entity.dart';

class StadiumModel extends StadiumEntity {
  StadiumModel({required super.id, required super.stadiumName});

  factory StadiumModel.fromJson(Map<String, dynamic> json) {
    return StadiumModel(
      id: json['_id'] as String? ?? '',
      stadiumName: json['stadiumName'] as String? ?? 'Unknown Stadium',
    );
  }
}
