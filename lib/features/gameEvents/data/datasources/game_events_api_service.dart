import 'package:dio/dio.dart';
import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/gameEvents/data/models/game_event_model.dart';

class GameEventsApiService {
  final Dio dio;

  GameEventsApiService(this.dio);

  Future<List<GameEventModel>> getGameEvents(int fixtureId) async {
    try {
      final response = await dio.get(
        'https://api-football-v1.p.rapidapi.com/v3/fixtures/events',
        queryParameters: {'fixture': fixtureId.toString()},
        options: Options(
          headers: {
            'x-rapidapi-key': AppConfig.footballApiKey,
            'x-rapidapi-host': AppConfig.xRapidapiHost,
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> eventsJson = response.data['response'];
        return eventsJson.map((json) => GameEventModel.fromJson(json)).toList();
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
