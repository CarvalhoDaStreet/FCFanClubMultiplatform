import 'package:dio/dio.dart';
import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/standings/data/datasources/standings_api_service.dart';
import 'package:fc_fan_club/features/standings/domain/entities/standings.dart';
import 'package:fc_fan_club/features/standings/domain/repository/standings_repository.dart';

class StandingsRepositoryImpl implements StandingsRepository {
  final StandingsApiService standingsApiService;

  StandingsRepositoryImpl(this.standingsApiService);

  @override
  Future<DataState<Standings>> getStandings(int leagueId, int season) async {
    try {
      final standings = await standingsApiService.getStandings(leagueId, season);
      return DataSuccess(standings);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
