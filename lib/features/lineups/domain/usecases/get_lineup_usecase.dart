import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/lineups/domain/entities/lineup.dart';
import 'package:fc_fan_club/features/lineups/domain/repository/lineup_repository.dart';

class GetLineupsUseCase {
  final LineupsRepository lineupsRepository;

  GetLineupsUseCase(this.lineupsRepository);

  Future<DataState<Lineups>> call(int fixtureId) {
    return lineupsRepository.getLineups(fixtureId);
  }
}
