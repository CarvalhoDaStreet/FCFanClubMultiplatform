import 'package:fc_fan_club/features/gameEvents/domain/entities/game_event.dart';

class GameEventModel extends GameEvent {
  GameEventModel({
    required Time time,
    required Team team,
    required Player player,
    Assist? assist,
    required String type,
    required String detail,
    String? comments,
  }) : super(
          time: time,
          team: team,
          player: player,
          assist: assist,
          type: type,
          detail: detail,
          comments: comments,
        );

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
  TimeModel({required int elapsed, int? extra}) : super(elapsed: elapsed, extra: extra);

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      elapsed: json['elapsed'] ?? 0,
      extra: json['extra'],
    );
  }
}

class TeamModel extends Team {
  TeamModel({required int id, required String name, required String logo}) : super(id: id, name: name, logo: logo);

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}

class PlayerModel extends Player {
  PlayerModel({required int id, required String name}) : super(id: id, name: name);

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class AssistModel extends Assist {
  AssistModel({int? id, String? name}) : super(id: id, name: name);

  factory AssistModel.fromJson(Map<String, dynamic> json) {
    return AssistModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
