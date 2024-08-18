import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/lineups/domain/entities/lineup.dart';

abstract class LineupsState extends Equatable {
  const LineupsState();

  @override
  List<Object> get props => [];
}

class LineupsInitial extends LineupsState {}

class LineupsLoading extends LineupsState {}

class LineupsLoaded extends LineupsState {
  final Lineups lineups;

  const LineupsLoaded(this.lineups);

  @override
  List<Object> get props => [lineups];
}

class LineupsError extends LineupsState {
  final String message;

  const LineupsError(this.message);

  @override
  List<Object> get props => [message];
}
