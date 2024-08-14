import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gameEvents/domain/entities/game_event.dart';

abstract class GameEventsRepository {
  Future<DataState<List<GameEvent>>> getGameEvents(int fixtureId);
}
