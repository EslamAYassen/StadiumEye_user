import '../../domain/entities/stadiums_response_entity.dart';
import 'stadium_list_model.dart';

class StadiumsResponseModel extends StadiumsResponseEntity {
  StadiumsResponseModel({
    required super.status,
    required super.totalResults,
    required super.stadiums,
  });

  factory StadiumsResponseModel.fromJson(Map<String, dynamic> json) {
    return StadiumsResponseModel(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      stadiums: (json['stadiums'] as List)
          .map(
            (stadium) =>
                StadiumListModel.fromJson(stadium as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
