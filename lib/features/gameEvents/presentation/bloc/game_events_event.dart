import 'package:equatable/equatable.dart';

abstract class GameEventsEvent extends Equatable {
  const GameEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadGameEventsEvent extends GameEventsEvent {
  final int fixtureId;

  const LoadGameEventsEvent(this.fixtureId);

  @override
  List<Object> get props => [fixtureId];
}
