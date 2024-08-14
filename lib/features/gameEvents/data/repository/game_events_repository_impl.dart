import 'package:dio/dio.dart';
import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gameEvents/data/datasources/game_events_api_service.dart';
import 'package:fc_fan_club/features/gameEvents/domain/entities/game_event.dart';
import 'package:fc_fan_club/features/gameEvents/domain/repository/game_events_repository.dart';

class GameEventsRepositoryImpl implements GameEventsRepository {
  final GameEventsApiService gameEventsApiService;

  GameEventsRepositoryImpl(this.gameEventsApiService);

  @override
  Future<DataState<List<GameEvent>>> getGameEvents(int fixtureId) async {
    try {
      final gameEvents = await gameEventsApiService.getGameEvents(fixtureId);
      return DataSuccess(gameEvents);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
