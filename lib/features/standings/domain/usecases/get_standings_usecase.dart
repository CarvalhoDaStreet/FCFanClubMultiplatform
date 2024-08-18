import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/standings/domain/entities/standings.dart';
import 'package:fc_fan_club/features/standings/domain/repository/standings_repository.dart';

class GetStandingsUseCase {
  final StandingsRepository standingsRepository;

  GetStandingsUseCase(this.standingsRepository);

  Future<DataState<Standings>> call(int leagueId, int season) {
    return standingsRepository.getStandings(leagueId, season);
  }
}
