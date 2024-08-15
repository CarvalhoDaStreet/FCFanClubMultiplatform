import 'package:fc_fan_club/features/gameEvents/domain/entities/game_event.dart';

class GameEventModel extends GameEvent {
  GameEventModel({
    required super.time,
    required super.team,
    required super.player,
    super.assist,
    required super.type,
    required super.detail,
    super.comments,
  });

  factory GameEventModel.fromJson(Map<String, dynamic> json) {
    return GameEventModel(
      time: TimeModel.fromJson(json['time']),
      team: TeamModel.fromJson(json['team']),
      player: PlayerModel.fromJson(json['player']),
      assist: json['assist'] != null ? AssistModel.fromJson(json['assist']) : null,
      type: json['type'] ?? '',
      detail: json['detail'] ?? '',
      comments: json['comments'] ?? '',
    );
  }
}

class TimeModel extends Time {
  TimeModel({required super.elapsed, super.extra});

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      elapsed: json['elapsed'] ?? 0,
      extra: json['extra'],
    );
  }
}

class TeamModel extends Team {
  TeamModel({required super.id, required super.name, required super.logo});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}

class PlayerModel extends Player {
  PlayerModel({required super.id, required super.name});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class AssistModel extends Assist {
  AssistModel({super.id, super.name});

  factory AssistModel.fromJson(Map<String, dynamic> json) {
    return AssistModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
