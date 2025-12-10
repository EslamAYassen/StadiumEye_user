import 'city_entity.dart';

class CitiesResponseEntity {
  final String status;
  final int totalResults;
  final List<CityEntity> cities;

  CitiesResponseEntity({
    required this.status,
    required this.totalResults,
    required this.cities,
  });
}
