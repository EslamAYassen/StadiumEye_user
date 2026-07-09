import 'matches_res.dart';

/// Entities for the "nearby stadium" lookup, added to the matches feature
/// since the fixture shape returned by the endpoint is identical to the
/// existing [Response] entity used across matches.

class NearbyStadiumDataEntity {
  final StadiumProximityEntity stadium;
  final VenueDetailsEntity venue;
  final Response fixture;
  final SavedUserMatchEntity? savedUser;

  NearbyStadiumDataEntity({
    required this.stadium,
    required this.venue,
    required this.fixture,
    this.savedUser,
  });
}

class StadiumProximityEntity {
  final StadiumLocationEntity location;
  final NearbyCityEntity? city;
  final bool isActive;
  final double distance;

  StadiumProximityEntity({
    required this.location,
    this.city,
    required this.isActive,
    required this.distance,
  });
}

class StadiumLocationEntity {
  final String name;
  final double lat;
  final double lng;
  final String? address;

  StadiumLocationEntity({
    required this.name,
    required this.lat,
    required this.lng,
    this.address,
  });
}

class NearbyCityEntity {
  final String id;
  final String nameEn;
  final String nameAr;
  final NearbyCountryEntity? country;

  NearbyCityEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.country,
  });
}

class NearbyCountryEntity {
  final String id;
  final String nameEn;
  final String nameAr;

  NearbyCountryEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });
}

class VenueDetailsEntity {
  final int id;
  final String name;
  final String? address;
  final String? city;
  final String? country;
  final int? capacity;
  final String? surface;
  final String? image;

  VenueDetailsEntity({
    required this.id,
    required this.name,
    this.address,
    this.city,
    this.country,
    this.capacity,
    this.surface,
    this.image,
  });
}

class SavedUserMatchEntity {
  final String homeTeam;
  final String awayTeam;
  final DateTime? time;
  final String? stadiumId;
  final int? venueId;

  SavedUserMatchEntity({
    required this.homeTeam,
    required this.awayTeam,
    this.time,
    this.stadiumId,
    this.venueId,
  });
}
