import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/standings/domain/entities/standings.dart';

abstract class StandingsRepository {
  Future<DataState<Standings>> getStandings(int leagueId, int season);
}
