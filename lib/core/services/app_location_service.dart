import 'package:location/location.dart';

enum LocationRequestStatus {
  success,
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  error,
}

class LocationResult {
  final LocationRequestStatus status;
  final double? latitude;
  final double? longitude;

  LocationResult({required this.status, this.latitude, this.longitude});
}

/// Thin wrapper around the `location` package (^8.0.1) that centralizes
/// service/permission checks so features only ever call
/// [getCurrentLocation] and react to a typed [LocationResult].
class AppLocationService {
  final Location _location = Location();

  Future<LocationResult> getCurrentLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return LocationResult(status: LocationRequestStatus.serviceDisabled);
        }
      }

      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
      }

      if (permission == PermissionStatus.deniedForever) {
        return LocationResult(
          status: LocationRequestStatus.permissionDeniedForever,
        );
      }

      if (permission == PermissionStatus.denied) {
        return LocationResult(status: LocationRequestStatus.permissionDenied);
      }

      final locationData = await _location.getLocation();

      if (locationData.latitude == null || locationData.longitude == null) {
        return LocationResult(status: LocationRequestStatus.error);
      }

      return LocationResult(
        status: LocationRequestStatus.success,
        latitude: locationData.latitude,
        longitude: locationData.longitude,
      );
    } catch (_) {
      return LocationResult(status: LocationRequestStatus.error);
    }
  }
}
