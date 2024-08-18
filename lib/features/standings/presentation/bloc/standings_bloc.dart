import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/standings/domain/usecases/get_standings_usecase.dart';
import 'package:fc_fan_club/features/standings/presentation/bloc/standings_event.dart';
import 'package:fc_fan_club/features/standings/presentation/bloc/standings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StandingsBloc extends Bloc<StandingsEvent, StandingsState> {
  final GetStandingsUseCase getStandingsUseCase;

  StandingsBloc(this.getStandingsUseCase) : super(StandingsInitial()) {
    on<LoadStandingsEvent>(_onLoadStandings);
  }

  void _onLoadStandings(LoadStandingsEvent event, Emitter<StandingsState> emit) async {
    emit(StandingsLoading());
    final dataState = await getStandingsUseCase.call(event.leagueId, event.season);
    if (dataState is DataSuccess) {
      emit(StandingsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(StandingsError(dataState.error.toString()));
    }
  }
}
