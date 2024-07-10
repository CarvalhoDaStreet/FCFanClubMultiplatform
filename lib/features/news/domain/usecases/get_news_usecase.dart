import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/news/domain/entities/news.dart';
import 'package:fc_fan_club/features/news/domain/repository/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository newsRepository;

  GetNewsUseCase(this.newsRepository);

  Future<DataState<List<News>>> call(int page, int pageSize) {
    return newsRepository.getNews(page, pageSize);
  }
}
