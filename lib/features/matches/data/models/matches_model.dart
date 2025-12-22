// lib/features/matches/data/models/match_response_model.dart
import '../../domain/entities/matches_res.dart';

class MatchResponseModel extends ParantMatchesRes {
  MatchResponseModel({
    required super.errors,
    required super.results,
    required super.response,
  });

  factory MatchResponseModel.fromJson(Map<String, dynamic> json) {
    return MatchResponseModel(
      errors: List<dynamic>.from(json['errors'] ?? []),
      results: json['results'] ?? 0,
      response: (json['response'] as List<dynamic>?)
          ?.map((e) => ResponseModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errors': errors,
      'results': results,
      'response': response.map((e) => (e as ResponseModel).toJson()).toList(),
    };
  }
}

class ResponseModel extends Response {
  ResponseModel({
    required super.fixture,
    required super.league,
    required super.teams,
    required super.goals,
    required super.score,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      fixture: FixtureModel.fromJson(json['fixture'] ?? {}),
      league: LeagueModel.fromJson(json['league'] ?? {}),
      teams: TeamsModel.fromJson(json['teams'] ?? {}),
      goals: GoalsModel.fromJson(json['goals'] ?? {}),
      score: ScoreModel.fromJson(json['score'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fixture': (fixture as FixtureModel).toJson(),
      'league': (league as LeagueModel).toJson(),
      'teams': (teams as TeamsModel).toJson(),
      'goals': (goals as GoalsModel).toJson(),
      'score': (score as ScoreModel).toJson(),
    };
  }
}

class FixtureModel extends Fixture {
  FixtureModel({
    required super.id,
    super.referee,
    required super.timezone,
    super.date,
    super.timestamp,
    required super.periods,
    required super.venue,
    required super.status,
  });

  factory FixtureModel.fromJson(Map<String, dynamic> json) {
    return FixtureModel(
      id: json['id'] ?? 0,
      referee: json['referee'],
      timezone: _timezoneFromString(json['timezone']),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      timestamp: json['timestamp'],
      periods: PeriodsModel.fromJson(json['periods'] ?? {}),
      venue: VenueModel.fromJson(json['venue'] ?? {}),
      status: StatusModel.fromJson(json['status'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referee': referee,
      'timezone': _timezoneToString(timezone),
      'date': date?.toIso8601String(),
      'timestamp': timestamp,
      'periods': (periods as PeriodsModel).toJson(),
      'venue': (venue as VenueModel).toJson(),
      'status': (status as StatusModel).toJson(),
    };
  }

  static Timezone _timezoneFromString(dynamic value) {
    if (value == null || value.toString().toUpperCase() == 'UTC') {
      return Timezone.UTC;
    }
    return Timezone.UTC;
  }

  static String _timezoneToString(Timezone timezone) {
    return 'UTC';
  }
}

class PeriodsModel extends Periods {
  PeriodsModel({super.first, super.second});

  factory PeriodsModel.fromJson(Map<String, dynamic> json) {
    return PeriodsModel(
      first: json['first'],
      second: json['second'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'second': second,
    };
  }
}

class StatusModel extends Status {
  StatusModel({super.long, super.short, super.elapsed, super.extra});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      long: _longFromString(json['long']),
      short: _shortFromString(json['short']),
      elapsed: json['elapsed'],
      extra: json['extra'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long': _longToString(long),
      'short': _shortToString(short),
      'elapsed': elapsed,
      'extra': extra,
    };
  }

  static Long? _longFromString(dynamic value) {
    if (value == null) return null;
    switch (value.toString()) {
      case 'Match Finished':
        return Long.MATCH_FINISHED;
      case 'Match Postponed':
        return Long.MATCH_POSTPONED;
      case 'Not Started':
        return Long.NOT_STARTED;
      case 'Second Half':
        return Long.SECOND_HALF;
      case 'First Half':
        return Long.FIRST_HALF;
      default:
        return null;
    }
  }

  static String? _longToString(Long? value) {
    if (value == null) return null;
    switch (value) {
      case Long.MATCH_FINISHED:
        return 'Match Finished';
      case Long.MATCH_POSTPONED:
        return 'Match Postponed';
      case Long.NOT_STARTED:
        return 'Not Started';
      case Long.SECOND_HALF:
        return 'Second Half';
      case Long.FIRST_HALF:
        return 'First Half';
    }
  }

  static Short? _shortFromString(dynamic value) {
    if (value == null) return null;
    switch (value.toString()) {
      case 'FT':
        return Short.FT;
      case 'PST':
        return Short.PST;
      case 'NS':
        return Short.NS;
      case '2H':
        return Short.THE_2_H;
      case '1H':
        return Short.THE_1_H;
      default:
        return null;
    }
  }

  static String? _shortToString(Short? value) {
    if (value == null) return null;
    switch (value) {
      case Short.FT:
        return 'FT';
      case Short.PST:
        return 'PST';
      case Short.NS:
        return 'NS';
      case Short.THE_2_H:
        return '2H';
      case Short.THE_1_H:
        return '1H';
    }
  }
}

class VenueModel extends Venue {
  VenueModel({super.id, super.name, super.city});

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
    };
  }
}

class TeamsModel extends Teams {
  TeamsModel({required super.home, required super.away});

  factory TeamsModel.fromJson(Map<String, dynamic> json) {
    return TeamsModel(
      home: TeamModel.fromJson(json['home'] ?? {}),
      away: TeamModel.fromJson(json['away'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': (home as TeamModel).toJson(),
      'away': (away as TeamModel).toJson(),
    };
  }
}

class TeamModel extends AwayAndHomeClass {
  TeamModel({
    required super.id,
    super.name,
    super.logo,
    super.winner,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? 0,
      name: json['name'],
      logo: json['logo'],
      winner: json['winner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'winner': winner,
    };
  }
}

class GoalsModel extends Goals {
  GoalsModel({super.home, super.away});

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class LeagueModel extends League {
  LeagueModel({
    required super.id,
    super.name,
    super.country,
    super.logo,
    super.flag,
    super.season,
    super.round,
    super.standings,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      id: json['id'] ?? 0,
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
      season: json['season'],
      round: json['round'],
      standings: json['standings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'logo': logo,
      'flag': flag,
      'season': season,
      'round': round,
      'standings': standings,
    };
  }
}

class ScoreModel extends Score {
  ScoreModel({
    required super.halftime,
    required super.fulltime,
    required super.extratime,
    required super.penalty,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      halftime: GoalsModel.fromJson(json['halftime'] ?? {}),
      fulltime: GoalsModel.fromJson(json['fulltime'] ?? {}),
      extratime: GoalsModel.fromJson(json['extratime'] ?? {}),
      penalty: GoalsModel.fromJson(json['penalty'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'halftime': (halftime as GoalsModel).toJson(),
      'fulltime': (fulltime as GoalsModel).toJson(),
      'extratime': (extratime as GoalsModel).toJson(),
      'penalty': (penalty as GoalsModel).toJson(),
    };
  }
}