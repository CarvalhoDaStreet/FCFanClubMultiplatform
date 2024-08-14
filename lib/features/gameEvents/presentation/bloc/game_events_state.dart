import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/gameEvents/domain/entities/game_event.dart';

abstract class GameEventsState extends Equatable {
  const GameEventsState();

  @override
  List<Object> get props => [];
}

class GameEventsInitial extends GameEventsState {}

class GameEventsLoading extends GameEventsState {}

class GameEventsLoaded extends GameEventsState {
  final List<GameEvent> gameEvents;

  const GameEventsLoaded(this.gameEvents);

  @override
  List<Object> get props => [gameEvents];
}

class GameEventsError extends GameEventsState {
  final String message;

  const GameEventsError(this.message);

  @override
  List<Object> get props => [message];
}
