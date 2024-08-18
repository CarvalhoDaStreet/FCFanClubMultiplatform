import 'package:dio/dio.dart';
import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/standings/data/models/standings_model.dart';

class StandingsApiService {
  final Dio dio;

  StandingsApiService(this.dio);

  Future<StandingsModel> getStandings(int leagueId, int season) async {
    try {
      final response = await dio.get(
        'https://api-football-v1.p.rapidapi.com/v3/standings',
        queryParameters: {
          'league': leagueId.toString(),
          'season': season.toString(),
        },
        options: Options(
          headers: {
            'x-rapidapi-key': AppConfig.footballApiKey,
            'x-rapidapi-host': AppConfig.xRapidapiHost,
          },
        ),
      );

      if (response.statusCode == 200) {
        return StandingsModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      rethrow;
    } catch (e) {
      print('General Exception: $e');
      rethrow;
    }
  }
}
