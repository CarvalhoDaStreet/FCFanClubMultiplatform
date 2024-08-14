class Fixtures {
  final int id;
  final String date;
  final String status;
  final String longStatus;
  final String homeTeam;
  final String awayTeam;
  final String venue;
  final String league;
  final String leagueLogo;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final int homeTeamId;
  final int awayTeamId;
  final int? homeGoals;
  final int? awayGoals;
  final String? halftimeScore;
  final String? fulltimeScore;
  final String? extratimeScore;
  final String? penaltyScore;

  Fixtures({
    required this.id,
    required this.date,
    required this.status,
    required this.longStatus,
    required this.homeTeam,
    required this.awayTeam,
    required this.venue,
    required this.league,
    required this.leagueLogo,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.homeGoals,
    required this.awayGoals,
    required this.halftimeScore,
    required this.fulltimeScore,
    required this.extratimeScore,
    required this.penaltyScore,
  });
}
