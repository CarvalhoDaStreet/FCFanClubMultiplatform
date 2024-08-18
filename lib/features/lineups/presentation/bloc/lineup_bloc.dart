import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/lineups/domain/usecases/get_lineup_usecase.dart';
import 'package:fc_fan_club/features/lineups/presentation/bloc/lineup_event.dart';
import 'package:fc_fan_club/features/lineups/presentation/bloc/lineup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LineupsBloc extends Bloc<LineupsEvent, LineupsState> {
  final GetLineupsUseCase getLineupsUseCase;

  LineupsBloc(this.getLineupsUseCase) : super(LineupsInitial()) {
    on<LoadLineupsEvent>(_onLoadLineups);
  }

  void _onLoadLineups(LoadLineupsEvent event, Emitter<LineupsState> emit) async {
    emit(LineupsLoading());
    final dataState = await getLineupsUseCase.call(event.fixtureId);
    if (dataState is DataSuccess) {
      emit(LineupsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(LineupsError(dataState.error.toString()));
    }
  }
}
