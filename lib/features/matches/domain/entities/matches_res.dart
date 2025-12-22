// ignore_for_file: constant_identifier_names

class ParantMatchesRes {
  ParantMatchesRes({
    // required this.get,
    // required this.parameters,
    required this.errors,
    required this.results,
    // required this.paging,
    required this.response,
  });

  // String get;
  // Parameters parameters;
  List<dynamic> errors;
  int results;
  // Paging paging;
  List<Response> response;
}

// class Paging {
//   Paging({required this.current, required this.total});

//   int current;
//   int total;
// }

// class Parameters {
//   Parameters({required this.date});

//   DateTime date;
// }

class Response {
  Response({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  Fixture fixture;
  League league;
  Teams teams;
  Goals goals;
  Score score;
}

class Fixture {
  Fixture({
    required this.id,
    this.referee,
    required this.timezone,
    this.date,
    this.timestamp,
    required this.periods,
    required this.venue,
    required this.status,
  });

  int id;
  dynamic referee;
  Timezone timezone;
  DateTime? date;
  int? timestamp;
  Periods periods;
  Venue venue;
  Status status;
}

class Periods {
  Periods({this.first, this.second});

  int? first;
  int? second;
}

class Status {
  Status({this.long, this.short, this.elapsed, this.extra});

  Long? long;
  Short? short;
  int? elapsed;
  int? extra;
}

enum Long {
  MATCH_FINISHED,
  MATCH_POSTPONED,
  NOT_STARTED,
  SECOND_HALF,
  FIRST_HALF,
}

enum Short { FT, PST, NS, THE_2_H, THE_1_H }

enum Timezone { UTC }

class Venue {
  Venue({this.id, this.name, this.city});

  int? id;
  String? name;
  String? city;
}

class Teams {
  Teams({required this.home, required this.away});

  AwayAndHomeClass home;
  AwayAndHomeClass away;
}

class Goals {
  Goals({this.home, this.away});

  dynamic home;
  dynamic away;
}

class AwayAndHomeClass {
  AwayAndHomeClass({required this.id, this.name, this.logo, this.winner});

  int id;
  String? name;
  String? logo;
  bool? winner;
}

class League {
  League({
    required this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.round,
    this.standings,
  });

  final int id;
  final String? name;
  final String? country;
  final String? logo;
  final String? flag;
  final int? season;
  final String? round;
  final bool? standings;
}

class Score {
  Score({
    required this.halftime,
    required this.fulltime,
    required this.extratime,
    required this.penalty,
  });

  Goals halftime;
  Goals fulltime;
  Goals extratime;
  Goals penalty;
}
