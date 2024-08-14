class GameEvent {
  final Time time;
  final Team team;
  final Player player;
  final Assist? assist;
  final String type;
  final String detail;
  final String? comments;

  GameEvent({
    required this.time,
    required this.team,
    required this.player,
    this.assist,
    required this.type,
    required this.detail,
    this.comments,
  });
}

class Time {
  final int elapsed;
  final int? extra;

  Time({required this.elapsed, this.extra});
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({required this.id, required this.name, required this.logo});
}

class Player {
  final int id;
  final String name;

  Player({required this.id, required this.name});
}

class Assist {
  final int? id;
  final String? name;

  Assist({this.id, this.name});
}
