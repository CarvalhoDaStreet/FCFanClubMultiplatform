import 'package:dio/dio.dart';
import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/fixtures/data/datasources/fixtures_api_service.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:fc_fan_club/features/fixtures/domain/repository/fixtures_repository.dart';

class FixturesRepositoryImpl implements FixturesRepository {
  final FixturesApiService fixturesApiService;

  FixturesRepositoryImpl(this.fixturesApiService);

  @override
  Future<DataState<List<Fixtures>>> getFixtures(int next) async {
    try {
      final fixtures = await fixturesApiService.fetchFixtures(next);
      return DataSuccess(fixtures);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
