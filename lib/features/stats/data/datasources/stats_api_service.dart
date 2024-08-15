import 'package:dio/dio.dart';
import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/stats/data/models/stats_model.dart';

class FootballStatisticsApiService {
  final Dio dio;

  FootballStatisticsApiService(this.dio);

  Future<FootballStatisticsModel> getFootballStatistics(int fixtureId) async {
    try {
      final response = await dio.get(
        'https://api-football-v1.p.rapidapi.com/v3/fixtures/statistics',
        queryParameters: {'fixture': fixtureId.toString()},
        options: Options(
          headers: {
            'x-rapidapi-key': AppConfig.footballApiKey,
            'x-rapidapi-host': AppConfig.xRapidapiHost,
          },
        ),
      );

      if (response.statusCode == 200) {
        return FootballStatisticsModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
      );
    } catch (e) {
      print('General Exception: $e');
      rethrow;
    }
  }
}
