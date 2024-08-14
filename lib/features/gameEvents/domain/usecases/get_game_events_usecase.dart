import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gameEvents/domain/entities/game_event.dart';
import 'package:fc_fan_club/features/gameEvents/domain/repository/game_events_repository.dart';

class GetGameEventsUsecase {
  final GameEventsRepository gameEventsRepository;

  GetGameEventsUsecase(this.gameEventsRepository);

  Future<DataState<List<GameEvent>>> call(int fixtureId) {
    return gameEventsRepository.getGameEvents(fixtureId);
  }
}
