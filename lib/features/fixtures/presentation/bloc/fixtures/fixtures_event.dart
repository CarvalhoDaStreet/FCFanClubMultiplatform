import 'package:equatable/equatable.dart';

abstract class FixturesEvent extends Equatable {
  const FixturesEvent();

  @override
  List<Object> get props => [];
}

class LoadFixturesEvent extends FixturesEvent {
  final int next;

  const LoadFixturesEvent(this.next);

  @override
  List<Object> get props => [next];
}
