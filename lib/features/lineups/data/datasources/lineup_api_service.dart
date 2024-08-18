import 'package:dio/dio.dart';
import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/lineups/data/models/lineup_model.dart';

class LineupsApiService {
  final Dio dio;

  LineupsApiService(this.dio);

  Future<LineupsModel> getLineups(int fixtureId) async {
    try {
      final response = await dio.get(
        'https://api-football-v1.p.rapidapi.com/v3/fixtures/lineups',
        queryParameters: {'fixture': fixtureId.toString()},
        options: Options(
          headers: {
            'x-rapidapi-key': AppConfig.footballApiKey,
            'x-rapidapi-host': AppConfig.xRapidapiHost,
          },
        ),
      );

      if (response.statusCode == 200) {
        return LineupsModel.fromJson(response.data);
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
