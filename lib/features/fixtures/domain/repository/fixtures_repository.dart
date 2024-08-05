import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';

abstract class FixturesRepository {
  Future<DataState<List<Fixtures>>> getFixtures(int next);
}
