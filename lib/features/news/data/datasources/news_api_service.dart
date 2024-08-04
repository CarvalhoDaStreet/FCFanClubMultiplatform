import 'package:dio/dio.dart';
import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/news/data/models/news_model.dart';

class NewsApiService {
  final Dio dio;
  NewsApiService(this.dio);

  Future<List<NewsModel>> fetchNews(int page, int pageSize) async {
    try {
      final response = await dio.get(
        '${AppConfig.strapiBaseUrl}/api/news?populate=%2A',
        queryParameters: {
          'pagination[page]': page,
          'pagination[pageSize]': pageSize,
        },
        options: Options(headers: {'Authorization': 'Bearer ${AppConfig.strapiApiKey}'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw DioException(
          requestOptions: e.requestOptions,
          response: e.response,
          error: e.error,
          type: e.type,
        );
      } else {
        rethrow;
      }
    }
  }
}
