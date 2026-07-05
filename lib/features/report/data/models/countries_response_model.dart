import '../../domain/entities/countries_response_entity.dart';

import 'country_model.dart';

class CountriesResponseModel extends CountriesResponseEntity {
  CountriesResponseModel({required super.status, required super.countries});

  factory CountriesResponseModel.fromJson(Map<String, dynamic> json) {
    return CountriesResponseModel(
      status: json['status'] as String? ?? '',
      countries: (json['data']['countries'] as List? ?? [])
          .map(
            (country) => CountryModel.fromJson(country as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
