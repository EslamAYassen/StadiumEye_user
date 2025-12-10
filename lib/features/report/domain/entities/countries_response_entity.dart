import 'country_entity.dart';

class CountriesResponseEntity {
  final String status;
  final List<CountryEntity> countries;

  CountriesResponseEntity({required this.status, required this.countries});
}
