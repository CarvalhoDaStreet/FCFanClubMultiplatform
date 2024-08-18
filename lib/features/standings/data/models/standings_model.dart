import 'package:fc_fan_club/features/standings/domain/entities/standings.dart';

class StandingsModel extends Standings {
  StandingsModel({required super.response});

  factory StandingsModel.fromJson(Map<String, dynamic> json) {
    return StandingsModel(
      response: (json['response'] as List).map((item) => LeagueModel.fromJson(item['league'])).toList(),
    );
  }
}

class LeagueModel extends League {
  LeagueModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.flag,
    required super.season,
    required super.standings,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
      season: json['season'],
      standings: (json['standings'][0] as List).map((standing) => StandingModel.fromJson(standing)).toList(),
    );
  }
}

class StandingModel extends Standing {
  StandingModel({
    required super.rank,
    required super.team,
    required super.points,
    required super.goalsDiff,
    required super.group,
    required super.form,
    required super.status,
    required super.description,
    required super.all,
    required super.home,
    required super.away,
    required super.update,
  });

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    return StandingModel(
      rank: json['rank'],
      team: TeamModel.fromJson(json['team']),
      points: json['points'],
      goalsDiff: json['goalsDiff'],
      group: json['group'],
      form: json['form'],
      status: json['status'],
      description: json['description'],
      all: StatsModel.fromJson(json['all']),
      home: StatsModel.fromJson(json['home']),
      away: StatsModel.fromJson(json['away']),
      update: DateTime.parse(json['update']),
    );
  }
}

class TeamModel extends Team {
  TeamModel({required super.id, required super.name, required super.logo});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}

class StatsModel extends Stats {
  StatsModel({
    required super.played,
    required super.win,
    required super.draw,
    required super.lose,
    required super.goals,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      played: json['played'],
      win: json['win'],
      draw: json['draw'],
      lose: json['lose'],
      goals: GoalsModel.fromJson(json['goals']),
    );
  }
}

class GoalsModel extends Goals {
  GoalsModel({required super.goalsFor, required super.against});

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      goalsFor: json['for'],
      against: json['against'],
    );
  }
}
