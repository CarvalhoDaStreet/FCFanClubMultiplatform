import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/stats/domain/usecases/get_stats_usecase.dart';
import 'package:fc_fan_club/features/stats/presentation/bloc/stats_event.dart';
import 'package:fc_fan_club/features/stats/presentation/bloc/stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballStatisticsBloc extends Bloc<FootballStatisticsEvent, FootballStatisticsState> {
  final GetFootballStatisticsUseCase getFootballStatisticsUseCase;

  FootballStatisticsBloc(this.getFootballStatisticsUseCase) : super(FootballStatisticsInitial()) {
    on<LoadFootballStatisticsEvent>(_onLoadStatistics);
  }

  void _onLoadStatistics(LoadFootballStatisticsEvent event, Emitter<FootballStatisticsState> emit) async {
    emit(FootballStatisticsLoading());
    final dataState = await getFootballStatisticsUseCase.call(event.fixtureId);
    if (dataState is DataSuccess) {
      emit(FootballStatisticsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(FootballStatisticsError(dataState.error.toString()));
    }
  }
}
