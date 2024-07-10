import 'package:dio/dio.dart';
import 'package:fc_fan_club/features/news/data/models/news_model.dart';

class NewsApiService {
  final Dio dio;
  final String baseUrl = "http://localhost:1337/api";
  final String apiKey =
      "fb286100e80bb9a2a811db293ff2e93140dda2181739be098284308f0536c0b3921166ca2c4c2aa506b3de3965aecd74225c52946dcfdf248bd43793cf5ae335321b7e7fae10a5e18a13cf65b52310209ee1ad477305811cd7018636b549ce961f022a53a673b214cf7af9949ac7969890ca996c5c69b4a5da08bafaf00cdcd8";

  NewsApiService(this.dio);

  Future<List<NewsModel>> fetchNews(int page, int pageSize) async {
    try {
      final response = await dio.get(
        '$baseUrl/news?populate=%2A',
        queryParameters: {
          'pagination[page]': page,
          'pagination[pageSize]': pageSize,
        },
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
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
