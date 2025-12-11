import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/error/failures.dart';

import '../../domain/usecases/get_home_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeBloc({required this.getHomeDataUseCase}) : super(const HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<RefreshHomeDataEvent>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final result = await getHomeDataUseCase();

    result.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (homeData) => emit(HomeLoaded(homeData)),
    );
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Don't show loading on refresh, keep current state
    final result = await getHomeDataUseCase();

    result.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (homeData) => emit(HomeLoaded(homeData)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
