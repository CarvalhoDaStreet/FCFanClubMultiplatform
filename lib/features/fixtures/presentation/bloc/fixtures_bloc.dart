import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/fixtures/domain/usecases/get_fixtures_usecase.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FixturesBloc extends Bloc<FixturesEvent, FixturesState> {
  final GetFixturesUseCase getFixturesUseCase;

  FixturesBloc(this.getFixturesUseCase) : super(FixturesInitial()) {
    on<LoadFixturesEvent>(_onLoadFixtures);
  }

  void _onLoadFixtures(LoadFixturesEvent event, Emitter<FixturesState> emit) async {
    emit(FixturesLoading());
    final dataState = await getFixturesUseCase(event.next);
    if (dataState is DataSuccess) {
      emit(FixturesLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(FixturesError(dataState.error.toString()));
    }
  }
}
