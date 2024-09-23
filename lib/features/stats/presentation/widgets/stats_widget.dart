import 'package:fc_fan_club/features/stats/domain/entities/stats.dart';
import 'package:fc_fan_club/features/stats/presentation/bloc/stats_bloc.dart';
import 'package:fc_fan_club/features/stats/presentation/bloc/stats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FootballStatisticsWidget extends StatelessWidget {
  final int fixtureId;

  const FootballStatisticsWidget({super.key, required this.fixtureId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FootballStatisticsBloc, FootballStatisticsState>(
      builder: (context, state) {
        if (state is FootballStatisticsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FootballStatisticsLoaded) {
          if (state.footballStatistics.response.length != 2) {
            return _buildPlaceholder();
          }
          return _buildStatisticsGraph(state.footballStatistics);
        } else if (state is FootballStatisticsError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Match statistics not available',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check later for updates',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsGraph(Stats statistics) {
    if (statistics.response.length != 2) {
      return const Center(child: Text("Invalid statistics data"));
    }

    final homeStats = statistics.response[0].statistics;
    final awayStats = statistics.response[1].statistics;

    return ListView.builder(
      itemCount: homeStats.length,
      itemBuilder: (context, index) {
        final homeStat = homeStats[index];
        final awayStat = awayStats[index];
        return _buildStatItem(homeStat, awayStat);
      },
    );
  }

  Widget _buildStatItem(Statistic homeStat, Statistic awayStat) {
    final homeValue = _parseStatValue(homeStat.value);
    final awayValue = _parseStatValue(awayStat.value);

    // Calculate maxValue as the sum of homeValue and awayValue
    final maxValue = homeValue + awayValue;

    // Avoid division by zero
    final homeProgress = maxValue > 0 ? homeValue / maxValue : 0.0;
    final awayProgress = maxValue > 0 ? awayValue / maxValue : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Text(
            homeStat.type,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeValue.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: homeProgress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      awayValue.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: awayProgress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _parseStatValue(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }
}
