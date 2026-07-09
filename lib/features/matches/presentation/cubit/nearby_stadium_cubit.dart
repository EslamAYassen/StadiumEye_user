import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/app_location_service.dart';
import '../../domain/entities/nearby_stadium_res.dart';
import '../../domain/usecases/get_nearby_stadium_usecase.dart';

enum NearbyStadiumStatus {
  initial,
  loading,
  loaded,
  locationServiceDisabled,
  locationPermissionDenied,
  error,
}

class NearbyStadiumState extends Equatable {
  final NearbyStadiumStatus status;
  final NearbyStadiumDataEntity? data;
  final String? message;

  const NearbyStadiumState({
    this.status = NearbyStadiumStatus.initial,
    this.data,
    this.message,
  });

  NearbyStadiumState copyWith({
    NearbyStadiumStatus? status,
    NearbyStadiumDataEntity? data,
    String? message,
  }) {
    return NearbyStadiumState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, data, message];
}

class NearbyStadiumCubit extends Cubit<NearbyStadiumState> {
  final GetNearbyStadiumUseCase getNearbyStadiumUseCase;
  final AppLocationService locationService;

  NearbyStadiumCubit({
    required this.getNearbyStadiumUseCase,
    required this.locationService,
  }) : super(const NearbyStadiumState());

  Future<void> fetchNearbyStadium() async {
    emit(state.copyWith(status: NearbyStadiumStatus.loading));

    final locationResult = await locationService.getCurrentLocation();

    switch (locationResult.status) {
      case LocationRequestStatus.serviceDisabled:
        emit(
          state.copyWith(status: NearbyStadiumStatus.locationServiceDisabled),
        );
        return;
      case LocationRequestStatus.permissionDenied:
      case LocationRequestStatus.permissionDeniedForever:
        emit(
          state.copyWith(status: NearbyStadiumStatus.locationPermissionDenied),
        );
        return;
      case LocationRequestStatus.error:
        emit(
          state.copyWith(
            status: NearbyStadiumStatus.error,
            message: 'Unable to get current location',
          ),
        );
        return;
      case LocationRequestStatus.success:
        break;
    }

    final result = await getNearbyStadiumUseCase(
      lat: locationResult.latitude!,
      lng: locationResult.longitude!,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NearbyStadiumStatus.error,
          message: failure.message,
        ),
      ),
      (data) =>
          emit(state.copyWith(status: NearbyStadiumStatus.loaded, data: data)),
    );
  }
}
