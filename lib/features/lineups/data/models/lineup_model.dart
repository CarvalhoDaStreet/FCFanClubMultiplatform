import 'package:fc_fan_club/features/lineups/domain/entities/lineup.dart';

class LineupsModel extends Lineups {
  LineupsModel({required super.response});

  factory LineupsModel.fromJson(Map<String, dynamic> json) {
    return LineupsModel(
      response: (json['response'] as List).map((teamLineup) => TeamLineupModel.fromJson(teamLineup)).toList(),
    );
  }
}

class TeamLineupModel extends TeamLineup {
  TeamLineupModel({
    required super.team,
    required super.coach,
    required super.formation,
    required super.startXI,
    required super.substitutes,
  });

  factory TeamLineupModel.fromJson(Map<String, dynamic> json) {
    return TeamLineupModel(
      team: TeamModel.fromJson(json['team']),
      coach: CoachModel.fromJson(json['coach']),
      formation: json['formation'],
      startXI: (json['startXI'] as List).map((player) => PlayerModel.fromJson(player['player'])).toList(),
      substitutes: (json['substitutes'] as List).map((player) => PlayerModel.fromJson(player['player'])).toList(),
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

class CoachModel extends Coach {
  CoachModel({required super.id, required super.name, required super.photo});

  factory CoachModel.fromJson(Map<String, dynamic> json) {
    return CoachModel(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
    );
  }
}

class PlayerModel extends Player {
  PlayerModel({required super.id, required super.name, required super.number, required super.pos, required super.grid});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      pos: json['pos'],
      grid: json['grid'],
    );
  }
}
