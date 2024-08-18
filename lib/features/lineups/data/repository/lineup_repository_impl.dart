import 'package:dio/dio.dart';
import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/lineups/data/datasources/lineup_api_service.dart';
import 'package:fc_fan_club/features/lineups/domain/entities/lineup.dart';
import 'package:fc_fan_club/features/lineups/domain/repository/lineup_repository.dart';

class LineupsRepositoryImpl implements LineupsRepository {
  final LineupsApiService lineupsApiService;

  LineupsRepositoryImpl(this.lineupsApiService);

  @override
  Future<DataState<Lineups>> getLineups(int fixtureId) async {
    try {
      final lineups = await lineupsApiService.getLineups(fixtureId);
      return DataSuccess(lineups);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
