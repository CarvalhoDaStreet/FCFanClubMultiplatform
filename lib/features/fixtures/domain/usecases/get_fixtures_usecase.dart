import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:fc_fan_club/features/fixtures/domain/repository/fixtures_repository.dart';

class GetFixturesUseCase {
  final FixturesRepository fixturesRepository;

  GetFixturesUseCase(this.fixturesRepository);

  Future<DataState<List<Fixtures>>> call(int next) {
    return fixturesRepository.getFixtures(next);
  }

  Future<DataState<List<Fixtures>>> callResults(int next) {
    return fixturesRepository.getResults(next);
  }
}
