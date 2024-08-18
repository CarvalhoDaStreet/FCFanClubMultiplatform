class Lineups {
  final List<TeamLineup> response;

  Lineups({required this.response});
}

class TeamLineup {
  final Team team;
  final Coach coach;
  final String formation;
  final List<Player> startXI;
  final List<Player> substitutes;

  TeamLineup({
    required this.team,
    required this.coach,
    required this.formation,
    required this.startXI,
    required this.substitutes,
  });
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({required this.id, required this.name, required this.logo});
}

class Coach {
  final int id;
  final String name;
  final String photo;

  Coach({required this.id, required this.name, required this.photo});
}

class Player {
  final int id;
  final String name;
  final int number;
  final String? pos;
  final String? grid;

  Player({required this.id, required this.name, required this.number, required this.pos, required this.grid});
}
