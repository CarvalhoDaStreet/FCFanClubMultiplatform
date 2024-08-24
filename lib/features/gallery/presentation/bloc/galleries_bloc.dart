import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gallery/domain/usecases/get_galleries_usecase.dart';
import 'package:fc_fan_club/features/gallery/presentation/bloc/galleries_event.dart';
import 'package:fc_fan_club/features/gallery/presentation/bloc/galleries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleriesBloc extends Bloc<GalleriesEvent, GalleriesState> {
  final GetGalleriesUseCase getGalleriesUseCase;

  GalleriesBloc(this.getGalleriesUseCase) : super(GalleriesInitial()) {
    on<LoadGalleriesEvent>(_onLoadGalleries);
  }

  void _onLoadGalleries(LoadGalleriesEvent event, Emitter<GalleriesState> emit) async {
    emit(GalleriesLoading());
    final dataState = await getGalleriesUseCase();
    if (dataState is DataSuccess) {
      emit(GalleriesLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(GalleriesError(dataState.error.toString()));
    }
  }
}
