import 'package:equatable/equatable.dart';

import '../../domain/entities/matches_res.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object?> get props => [];
}

class MatchesInitial extends MatchesState {}

class MatchesLoading extends MatchesState {}

class MatchesLoaded extends MatchesState {
  final ParantMatchesRes matches;
  final List<Response> filteredMatches;
  final MatchFilters filters;

  // Extracted unique values for filters
  final Set<String> availableLeagues;
  final Set<String> availableCountries;

  const MatchesLoaded({
    required this.matches,
    required this.filteredMatches,
    required this.filters,
    required this.availableLeagues,
    required this.availableCountries,
  });

  @override
  List<Object?> get props => [
    matches,
    filteredMatches,
    filters,
    availableLeagues,
    availableCountries,
  ];
}

class MatchesError extends MatchesState {
  final String message;

  const MatchesError(this.message);

  @override
  List<Object?> get props => [message];
}

// Filter Model
class MatchFilters extends Equatable {
  final String? league;
  final String? country;
  final String? status;

  const MatchFilters({this.league, this.country, this.status});

  MatchFilters copyWith({String? league, String? country, String? status}) {
    return MatchFilters(
      league: league ?? this.league,
      country: country ?? this.country,
      status: status ?? this.status,
    );
  }

  bool get hasActiveFilters =>
      (league != null && league != 'All') ||
      (country != null && country != 'All') ||
      (status != null && status != 'All');

  @override
  List<Object?> get props => [league, country, status];
}
