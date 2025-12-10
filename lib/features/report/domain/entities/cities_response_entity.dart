import 'city_entity.dart';

class CitiesResponseEntity {
  final String status;
  final List<CityEntity> cities;

  CitiesResponseEntity({required this.status, required this.cities});
}
