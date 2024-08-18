import 'package:equatable/equatable.dart';

abstract class LineupsEvent extends Equatable {
  const LineupsEvent();

  @override
  List<Object> get props => [];
}

class LoadLineupsEvent extends LineupsEvent {
  final int fixtureId;

  const LoadLineupsEvent(this.fixtureId);

  @override
  List<Object> get props => [fixtureId];
}
