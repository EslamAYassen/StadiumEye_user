import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/matches/data/repositories/matches_repository.dart';

import '../../domain/entities/matches_res.dart';
import 'matches_state.dart';

class MatchesCubit extends Cubit<MatchesState> {
  final MatchesRepository getMatches;

  MatchesCubit({required this.getMatches}) : super(MatchesInitial());

  // Store the original matches and current filters
  ParantMatchesRes? _originalMatches;
  MatchFilters _currentFilters = const MatchFilters();

  Future<void> getMatchesEvent({
    String? date,
    String? league,
    String? season,
    String? team,
  }) async {
    emit(MatchesLoading());

    final result = await getMatches.getMatches(
      date: date,
      league: league,
      season: season,
      team: team,
    );

    result.fold((failure) => emit(MatchesError(failure.message)), (matches) {
      _originalMatches = matches;
      _applyFiltersAndEmit();
    });
  }

  // Update filters
  void updateFilters({String? league, String? country, String? status}) {
    _currentFilters = MatchFilters(
      league: league,
      country: country,
      status: status,
    );
    _applyFiltersAndEmit();
  }

  // Clear all filters
  void clearFilters() {
    _currentFilters = const MatchFilters();
    _applyFiltersAndEmit();
  }

  // Apply filters and emit new state
  void _applyFiltersAndEmit() {
    emit(MatchesLoading());
    if (_originalMatches == null) return;

    final filteredMatches = _applyFilters(
      _originalMatches!.response,
      _currentFilters,
    );

    final availableLeagues = _extractUniqueLeagues(_originalMatches!.response);
    final availableCountries = _extractUniqueCountries(
      _originalMatches!.response,
    );

    emit(
      MatchesLoaded(
        matches: _originalMatches!,
        filteredMatches: filteredMatches,
        filters: _currentFilters,
        availableLeagues: availableLeagues,
        availableCountries: availableCountries,
      ),
    );
  }

  // Apply filters logic
  List<Response> _applyFilters(List<Response> matches, MatchFilters filters) {
    return matches.where((match) {
      // Filter by league
      if (filters.league != null && filters.league != 'All') {
        if (match.league.name != filters.league) return false;
      }

      // Filter by country
      if (filters.country != null && filters.country != 'All') {
        if (match.league.country != filters.country) return false;
      }

      // Filter by status
      if (filters.status != null && filters.status != 'All') {
        final statusMap = {
          'Not Started (NS)': 'NS',
          'First Half (1H)': '1H',
          'Halftime (HT)': 'HT',
          'Second Half (2H)': '2H',
          'Finished (FT)': 'FT',
          'Postponed (PST)': 'PST',
        };
        final statusCode = statusMap[filters.status];
        if (match.fixture.status.short?.toString() != statusCode) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  Set<String> _extractUniqueLeagues(List<Response> matches) {
    return matches
        .map((m) => m.league.name ?? '')
        .where((name) => name.isNotEmpty)
        .toSet();
  }

  // Extract unique countries
  Set<String> _extractUniqueCountries(List<Response> matches) {
    return matches
        .map((m) => m.league.country ?? '')
        .where((country) => country.isNotEmpty)
        .toSet();
  }

  void reset() {
    emit(MatchesInitial());
  }
}
