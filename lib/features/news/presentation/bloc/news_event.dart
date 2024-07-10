part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNews extends NewsEvent {
  final int page;
  final int pageSize;

  const FetchNews({required this.page, required this.pageSize});

  @override
  List<Object?> get props => [page, pageSize];
}
