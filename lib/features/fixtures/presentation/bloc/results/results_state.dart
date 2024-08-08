import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';

abstract class ResultsState extends Equatable {
  const ResultsState();

  @override
  List<Object> get props => [];
}

class ResultsInitial extends ResultsState {}

class ResultsLoading extends ResultsState {}

class ResultsLoaded extends ResultsState {
  final List<Fixtures> results;

  const ResultsLoaded(this.results);

  @override
  List<Object> get props => [results];
}

class ResultsError extends ResultsState {
  final String message;

  const ResultsError(this.message);

  @override
  List<Object> get props => [message];
}
