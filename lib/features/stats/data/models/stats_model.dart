import 'package:fc_fan_club/features/stats/domain/entities/stats.dart';

class FootballStatisticsModel extends Stats {
  FootballStatisticsModel({required super.response});

  factory FootballStatisticsModel.fromJson(Map<String, dynamic> json) {
    return FootballStatisticsModel(
      response: (json['response'] as List).map((teamStats) => TeamStatisticsModel.fromJson(teamStats)).toList(),
    );
  }
}

class TeamStatisticsModel extends TeamStatistics {
  TeamStatisticsModel({required super.statistics, required super.team});

  factory TeamStatisticsModel.fromJson(Map<String, dynamic> json) {
    return TeamStatisticsModel(
      statistics: (json['statistics'] as List).map((stat) => StatisticModel.fromJson(stat)).toList(),
      team: TeamModel.fromJson(json['team']),
    );
  }
}

class StatisticModel extends Statistic {
  StatisticModel({required super.type, required super.value});

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      type: json['type'] ?? '',
      value: json['value'],
    );
  }
}

class TeamModel extends Team {
  TeamModel({required super.id, required super.logo, required super.name});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? 0,
      logo: json['logo'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
