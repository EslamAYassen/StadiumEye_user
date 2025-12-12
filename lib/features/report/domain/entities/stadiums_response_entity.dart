import 'stadium_list_entity.dart';

class StadiumsResponseEntity {
  final String status;
  final int totalResults;
  final List<StadiumListEntity> stadiums;

  StadiumsResponseEntity({
    required this.status,
    required this.totalResults,
    required this.stadiums,
  });
}
