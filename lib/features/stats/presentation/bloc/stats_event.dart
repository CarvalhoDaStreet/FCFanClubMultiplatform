import 'package:equatable/equatable.dart';

abstract class FootballStatisticsEvent extends Equatable {
  const FootballStatisticsEvent();

  @override
  List<Object> get props => [];
}

class LoadFootballStatisticsEvent extends FootballStatisticsEvent {
  final int fixtureId;

  const LoadFootballStatisticsEvent(this.fixtureId);

  @override
  List<Object> get props => [fixtureId];
}
