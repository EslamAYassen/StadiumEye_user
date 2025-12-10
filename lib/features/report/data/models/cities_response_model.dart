import '../../domain/entities/cities_response_entity.dart';
import 'city_model.dart';

class CitiesResponseModel extends CitiesResponseEntity {
  CitiesResponseModel({
    required super.status,
    required super.totalResults,
    required super.cities,
  });

  factory CitiesResponseModel.fromJson(Map<String, dynamic> json) {
    return CitiesResponseModel(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      cities: (json['cities'] as List)
          .map((city) => CityModel.fromJson(city as Map<String, dynamic>))
          .toList(),
    );
  }
}
