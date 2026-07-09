import '../../domain/entities/nearby_stadium_res.dart';
import 'matches_model.dart';

class NearbyStadiumDataModel extends NearbyStadiumDataEntity {
  NearbyStadiumDataModel({
    required super.stadium,
    required super.venue,
    required super.fixture,
    super.savedUser,
  });

  factory NearbyStadiumDataModel.fromJson(Map<String, dynamic> json) {
    return NearbyStadiumDataModel(
      stadium: StadiumProximityModel.fromJson(
        json['stadium'] as Map<String, dynamic>? ?? {},
      ),
      venue: VenueDetailsModel.fromJson(
        json['venue'] as Map<String, dynamic>? ?? {},
      ),
      // Reuses the existing matches ResponseModel — the "fixture" object
      // returned by this endpoint has the same fixture/league/teams/goals/score shape.
      fixture: ResponseModel.fromJson(
        json['fixture'] as Map<String, dynamic>? ?? {},
      ),
      savedUser: json['savedUser'] != null
          ? SavedUserMatchModel.fromJson(
              json['savedUser'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class StadiumProximityModel extends StadiumProximityEntity {
  StadiumProximityModel({
    required super.location,
    super.city,
    required super.isActive,
    required super.distance,
  });

  factory StadiumProximityModel.fromJson(Map<String, dynamic> json) {
    return StadiumProximityModel(
      location: StadiumLocationModel.fromJson(
        json['location'] as Map<String, dynamic>? ?? {},
      ),
      city: json['city'] != null
          ? NearbyCityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
      isActive: json['isActive'] as bool? ?? false,
      distance: (json['distance'] as num?)?.toDouble() ?? 0,
    );
  }
}

class StadiumLocationModel extends StadiumLocationEntity {
  StadiumLocationModel({
    required super.name,
    required super.lat,
    required super.lng,
    super.address,
  });

  factory StadiumLocationModel.fromJson(Map<String, dynamic> json) {
    return StadiumLocationModel(
      name: json['name'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      address: json['address'] as String?,
    );
  }
}

class NearbyCityModel extends NearbyCityEntity {
  NearbyCityModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    super.country,
  });

  factory NearbyCityModel.fromJson(Map<String, dynamic> json) {
    return NearbyCityModel(
      id: json['_id'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      country: json['country'] != null
          ? NearbyCountryModel.fromJson(json['country'] as Map<String, dynamic>)
          : null,
    );
  }
}

class NearbyCountryModel extends NearbyCountryEntity {
  NearbyCountryModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
  });

  factory NearbyCountryModel.fromJson(Map<String, dynamic> json) {
    return NearbyCountryModel(
      id: json['_id'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
    );
  }
}

class VenueDetailsModel extends VenueDetailsEntity {
  VenueDetailsModel({
    required super.id,
    required super.name,
    super.address,
    super.city,
    super.country,
    super.capacity,
    super.surface,
    super.image,
  });

  factory VenueDetailsModel.fromJson(Map<String, dynamic> json) {
    return VenueDetailsModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      capacity: json['capacity'] as int?,
      surface: json['surface'] as String?,
      image: json['image'] as String?,
    );
  }
}

class SavedUserMatchModel extends SavedUserMatchEntity {
  SavedUserMatchModel({
    required super.homeTeam,
    required super.awayTeam,
    super.time,
    super.stadiumId,
    super.venueId,
  });

  factory SavedUserMatchModel.fromJson(Map<String, dynamic> json) {
    final match = json['match'] as Map<String, dynamic>? ?? {};
    final teams = match['teams'] as Map<String, dynamic>? ?? {};

    return SavedUserMatchModel(
      homeTeam: teams['homeTeam'] as String? ?? '',
      awayTeam: teams['awayTeam'] as String? ?? '',
      time: teams['time'] != null
          ? DateTime.tryParse(teams['time'] as String)
          : null,
      stadiumId: json['stadium'] as String?,
      venueId: json['venueId'] as int?,
    );
  }
}
