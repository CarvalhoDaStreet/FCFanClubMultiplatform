import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/news/domain/entities/news.dart';
import 'package:fc_fan_club/features/news/domain/usecases/get_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;

  NewsBloc(this.getNewsUseCase) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      final dataState = await getNewsUseCase(event.page, event.pageSize);
      if (dataState is DataSuccess) {
        emit(NewsLoaded(dataState.data!));
      } else {
        emit(NewsError(dataState.error!));
      }
    });
  }
}
