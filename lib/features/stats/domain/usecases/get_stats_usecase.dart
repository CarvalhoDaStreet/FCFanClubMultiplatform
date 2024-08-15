import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/stats/domain/entities/stats.dart';
import 'package:fc_fan_club/features/stats/domain/repository/stats_repository.dart';

class GetFootballStatisticsUseCase {
  final FootballStatisticsRepository footballStatisticsRepository;

  GetFootballStatisticsUseCase(this.footballStatisticsRepository);

  Future<DataState<Stats>> call(int fixtureId) {
    return footballStatisticsRepository.getFootballStatistics(fixtureId);
  }
}
