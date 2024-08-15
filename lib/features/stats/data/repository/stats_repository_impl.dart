import 'package:dio/dio.dart';
import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/stats/data/datasources/stats_api_service.dart';
import 'package:fc_fan_club/features/stats/domain/entities/stats.dart';
import 'package:fc_fan_club/features/stats/domain/repository/stats_repository.dart';

class FootballStatisticsRepositoryImpl implements FootballStatisticsRepository {
  final FootballStatisticsApiService footballStatisticsApiService;

  FootballStatisticsRepositoryImpl(this.footballStatisticsApiService);

  @override
  Future<DataState<Stats>> getFootballStatistics(int fixtureId) async {
    try {
      final footballStatistics = await footballStatisticsApiService.getFootballStatistics(fixtureId);
      return DataSuccess(footballStatistics);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
