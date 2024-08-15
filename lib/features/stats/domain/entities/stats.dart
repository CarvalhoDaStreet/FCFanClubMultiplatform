class Stats {
  final List<TeamStatistics> response;

  Stats({required this.response});
}

class TeamStatistics {
  final List<Statistic> statistics;
  final Team team;

  TeamStatistics({required this.statistics, required this.team});
}

class Statistic {
  final String type;
  final dynamic value;

  Statistic({required this.type, required this.value});
}

class Team {
  final int id;
  final String logo;
  final String name;

  Team({required this.id, required this.logo, required this.name});
}
