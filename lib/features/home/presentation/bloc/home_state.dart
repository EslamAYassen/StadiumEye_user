import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entites/home_data_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final HomeDataEntity homeData;

  const HomeLoaded(this.homeData);

  @override
  List<Object?> get props => [homeData];
}

class HomeError extends HomeState {
  /// The typed failure (AuthFailure / NetworkFailure / ServerFailure / ...)
  /// so the UI can render a different message, icon, and action per error
  /// type instead of one generic "something went wrong" screen.
  final Failure failure;

  const HomeError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}
