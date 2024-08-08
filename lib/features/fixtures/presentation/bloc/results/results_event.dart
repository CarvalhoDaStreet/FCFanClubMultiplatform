import 'package:equatable/equatable.dart';

abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object> get props => [];
}

class LoadResultsEvent extends ResultsEvent {
  final int last;

  const LoadResultsEvent(this.last);

  @override
  List<Object> get props => [last];
}
