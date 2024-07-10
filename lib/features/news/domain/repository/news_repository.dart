import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/news/domain/entities/news.dart';

abstract class NewsRepository {
  Future<DataState<List<News>>> getNews(int page, int pageSize);
}
