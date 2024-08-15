import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/stats/domain/entities/stats.dart';

abstract class FootballStatisticsState extends Equatable {
  const FootballStatisticsState();

  @override
  List<Object> get props => [];
}

class FootballStatisticsInitial extends FootballStatisticsState {}

class FootballStatisticsLoading extends FootballStatisticsState {}

class FootballStatisticsLoaded extends FootballStatisticsState {
  final Stats footballStatistics;

  const FootballStatisticsLoaded(this.footballStatistics);

  @override
  List<Object> get props => [footballStatistics];
}

class FootballStatisticsError extends FootballStatisticsState {
  final String message;

  const FootballStatisticsError(this.message);

  @override
  List<Object> get props => [message];
}
