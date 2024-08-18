import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/lineups/domain/entities/lineup.dart';

abstract class LineupsRepository {
  Future<DataState<Lineups>> getLineups(int fixtureId);
}
