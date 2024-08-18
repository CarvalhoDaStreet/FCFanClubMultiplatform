import 'package:equatable/equatable.dart';

abstract class StandingsEvent extends Equatable {
  const StandingsEvent();

  @override
  List<Object> get props => [];
}

class LoadStandingsEvent extends StandingsEvent {
  final int leagueId;
  final int season;

  const LoadStandingsEvent(this.leagueId, this.season);

  @override
  List<Object> get props => [leagueId, season];
}
