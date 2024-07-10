import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/news/data/datasources/news_api_service.dart';
import 'package:fc_fan_club/features/news/domain/entities/news.dart';
import 'package:fc_fan_club/features/news/domain/repository/news_repository.dart';
import 'package:dio/dio.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService newsApiService;

  NewsRepositoryImpl(this.newsApiService);

  @override
  Future<DataState<List<News>>> getNews(int page, int pageSize) async {
    try {
      final news = await newsApiService.fetchNews(page, pageSize);
      return DataSuccess(news);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
