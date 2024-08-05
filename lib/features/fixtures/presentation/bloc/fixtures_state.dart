import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';

abstract class FixturesState extends Equatable {
  const FixturesState();

  @override
  List<Object> get props => [];
}

class FixturesInitial extends FixturesState {}

class FixturesLoading extends FixturesState {}

class FixturesLoaded extends FixturesState {
  final List<Fixtures> fixtures;

  const FixturesLoaded(this.fixtures);

  @override
  List<Object> get props => [fixtures];
}

class FixturesError extends FixturesState {
  final String message;

  const FixturesError(this.message);

  @override
  List<Object> get props => [message];
}
