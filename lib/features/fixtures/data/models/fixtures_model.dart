import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';

class FixturesModel extends Fixtures {
  FixturesModel({
    required super.id,
    required super.date,
    required super.status,
    required super.longStatus,
    required super.homeTeam,
    required super.awayTeam,
    required super.venue,
    required super.league,
    required super.leagueLogo,
    required super.homeTeamLogo,
    required super.awayTeamLogo,
    required super.homeTeamId,
    required super.awayTeamId,
    required super.homeGoals,
    required super.awayGoals,
    required super.halftimeScore,
    required super.fulltimeScore,
    required super.extratimeScore,
    required super.penaltyScore,
  });

  factory FixturesModel.fromJson(Map<String, dynamic> json) {
    return FixturesModel(
      id: json['fixture']?['id'] ?? 0,
      date: json['fixture']?['date'] ?? '',
      status: json['fixture']?['status']?['short'] ?? '',
      longStatus: json['fixture']?['status']?['long'] ?? '',
      homeTeam: json['teams']?['home']?['name'] ?? '',
      awayTeam: json['teams']?['away']?['name'] ?? '',
      venue: json['fixture']?['venue']?['name'] ?? 'Informação sobre o local não esta disponível',
      league: json['league']?['name'] ?? '',
      leagueLogo: json['league']?['logo'] ?? '',
      homeTeamLogo: json['teams']?['home']?['logo'] ?? '',
      awayTeamLogo: json['teams']?['away']?['logo'] ?? '',
      homeTeamId: json['teams']?['home']?['id'] ?? 0,
      awayTeamId: json['teams']?['away']?['id'] ?? 0,
      homeGoals: json['goals']?['home'] ?? 0,
      awayGoals: json['goals']?['away'] ?? 0,
      halftimeScore: json['score']?['halftime'] != null ? '${json['score']['halftime']?['home'] ?? 0} - ${json['score']['halftime']?['away'] ?? 0}' : null,
      fulltimeScore: json['score']?['fulltime'] != null ? '${json['score']['fulltime']?['home'] ?? 0} - ${json['score']['fulltime']?['away'] ?? 0}' : null,
      extratimeScore: json['score']?['extratime'] != null ? '${json['score']['extratime']?['home'] ?? 0} - ${json['score']['extratime']?['away'] ?? 0}' : null,
      penaltyScore: json['score']?['penalty'] != null ? '${json['score']['penalty']?['home'] ?? 0} - ${json['score']['penalty']?['away'] ?? 0}' : null,
    );
  }
}
