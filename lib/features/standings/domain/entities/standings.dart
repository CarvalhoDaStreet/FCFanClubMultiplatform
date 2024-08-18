class Standings {
  final List<League> response;

  Standings({required this.response});
}

class League {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;
  final List<Standing> standings;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.standings,
  });
}

class Standing {
  final int rank;
  final Team team;
  final int points;
  final int goalsDiff;
  final String group;
  final String form;
  final String status;
  final String? description;
  final Stats all;
  final Stats home;
  final Stats away;
  final DateTime update;

  Standing({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    required this.group,
    required this.form,
    required this.status,
    required this.description,
    required this.all,
    required this.home,
    required this.away,
    required this.update,
  });
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({required this.id, required this.name, required this.logo});
}

class Stats {
  final int played;
  final int win;
  final int draw;
  final int lose;
  final Goals goals;

  Stats({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });
}

class Goals {
  final int goalsFor;
  final int against;

  Goals({required this.goalsFor, required this.against});
}
