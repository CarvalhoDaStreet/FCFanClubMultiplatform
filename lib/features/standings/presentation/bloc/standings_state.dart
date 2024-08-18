import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/standings/domain/entities/standings.dart';

abstract class StandingsState extends Equatable {
  const StandingsState();

  @override
  List<Object> get props => [];
}

class StandingsInitial extends StandingsState {}

class StandingsLoading extends StandingsState {}

class StandingsLoaded extends StandingsState {
  final Standings standings;

  const StandingsLoaded(this.standings);

  @override
  List<Object> get props => [standings];
}

class StandingsError extends StandingsState {
  final String message;

  const StandingsError(this.message);

  @override
  List<Object> get props => [message];
}
