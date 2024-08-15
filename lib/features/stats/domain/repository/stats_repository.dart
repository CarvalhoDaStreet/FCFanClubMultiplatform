import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/stats/domain/entities/stats.dart';

abstract class FootballStatisticsRepository {
  Future<DataState<Stats>> getFootballStatistics(int fixtureId);
}
