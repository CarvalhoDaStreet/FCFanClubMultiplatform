import 'package:dio/dio.dart';
import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/fixtures/data/models/fixtures_model.dart';

class FixturesApiService {
  final Dio dio;

  FixturesApiService(this.dio);

  Future<List<FixturesModel>> fetchFixtures(int next) async {
    try {
      final response = await dio.get(
        '${AppConfig.footballApiBaseUrl}/fixtures',
        queryParameters: {'season': AppConfig.season, 'team': AppConfig.teamId, 'next': next, 'timezone': AppConfig.timezone},
        options: Options(headers: {
          'x-rapidapi-key': AppConfig.footballApiKey,
          'x-rapidapi-host': AppConfig.xRapidapiHost,
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data['response'] as List;
        return data.map((json) => FixturesModel.fromJson(json)).toList();
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
