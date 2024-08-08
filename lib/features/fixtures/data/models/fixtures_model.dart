import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';

class FixturesModel extends Fixtures {
  FixturesModel({
    required int id,
    required String date,
    required String status,
    required String homeTeam,
    required String awayTeam,
    required String venue,
    required String league,
    required String leagueLogo,
    required String homeTeamLogo,
    required String awayTeamLogo,
    required int? homeGoals,
    required int? awayGoals,
    required String? halftimeScore,
    required String? fulltimeScore,
    required String? extratimeScore,
    required String? penaltyScore,
  }) : super(
          id: id,
          date: date,
          status: status,
          homeTeam: homeTeam,
          awayTeam: awayTeam,
          venue: venue,
          league: league,
          leagueLogo: leagueLogo,
          homeTeamLogo: homeTeamLogo,
          awayTeamLogo: awayTeamLogo,
          homeGoals: homeGoals,
          awayGoals: awayGoals,
          halftimeScore: halftimeScore,
          fulltimeScore: fulltimeScore,
          extratimeScore: extratimeScore,
          penaltyScore: penaltyScore,
        );

  factory FixturesModel.fromJson(Map<String, dynamic> json) {
    return FixturesModel(
      id: json['fixture']?['id'] ?? 0,
      date: json['fixture']?['date'] ?? '',
      status: json['fixture']?['status']?['short'] ?? '',
      homeTeam: json['teams']?['home']?['name'] ?? '',
      awayTeam: json['teams']?['away']?['name'] ?? '',
      venue: json['fixture']?['venue']?['name'] ?? 'Informação sobre o local não esta disponível',
      league: json['league']?['name'] ?? '',
      leagueLogo: json['league']?['logo'] ?? '',
      homeTeamLogo: json['teams']?['home']?['logo'] ?? '',
      awayTeamLogo: json['teams']?['away']?['logo'] ?? '',
      homeGoals: json['goals']?['home'] ?? 0,
      awayGoals: json['goals']?['away'] ?? 0,
      halftimeScore: json['score']?['halftime'] != null ? '${json['score']['halftime']?['home'] ?? 0} - ${json['score']['halftime']?['away'] ?? 0}' : null,
      fulltimeScore: json['score']?['fulltime'] != null ? '${json['score']['fulltime']?['home'] ?? 0} - ${json['score']['fulltime']?['away'] ?? 0}' : null,
      extratimeScore: json['score']?['extratime'] != null ? '${json['score']['extratime']?['home'] ?? 0} - ${json['score']['extratime']?['away'] ?? 0}' : null,
      penaltyScore: json['score']?['penalty'] != null ? '${json['score']['penalty']?['home'] ?? 0} - ${json['score']['penalty']?['away'] ?? 0}' : null,
    );
  }
}
