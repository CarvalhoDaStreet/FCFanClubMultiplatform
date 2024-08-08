import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/fixtures/domain/usecases/get_fixtures_usecase.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  final GetFixturesUseCase getFixturesUseCase;

  ResultsBloc(this.getFixturesUseCase) : super(ResultsInitial()) {
    on<LoadResultsEvent>(_onLoadResults);
  }

  void _onLoadResults(LoadResultsEvent event, Emitter<ResultsState> emit) async {
    emit(ResultsLoading());
    final dataState = await getFixturesUseCase.callResults(event.last);
    if (dataState is DataSuccess) {
      emit(ResultsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(ResultsError(dataState.error.toString()));
    }
  }
}
