import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gameEvents/domain/usecases/get_game_events_usecase.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/bloc/game_events_event.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/bloc/game_events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEventsBloc extends Bloc<GameEventsEvent, GameEventsState> {
  final GetGameEventsUsecase getGameEventsUsecase;

  GameEventsBloc(this.getGameEventsUsecase) : super(GameEventsInitial()) {
    on<LoadGameEventsEvent>(_onLoadFixtures);
  }

  void _onLoadFixtures(LoadGameEventsEvent event, Emitter<GameEventsState> emit) async {
    emit(GameEventsLoading());
    final dataState = await getGameEventsUsecase.call(event.fixtureId);
    if (dataState is DataSuccess) {
      emit(GameEventsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(GameEventsError(dataState.error.toString()));
    }
  }
}
