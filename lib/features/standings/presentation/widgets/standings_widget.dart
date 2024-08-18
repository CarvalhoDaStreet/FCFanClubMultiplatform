import 'package:fc_fan_club/features/standings/domain/entities/standings.dart';
import 'package:fc_fan_club/features/standings/presentation/bloc/standings_bloc.dart';
import 'package:fc_fan_club/features/standings/presentation/bloc/standings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class StandingsWidget extends StatelessWidget {
  const StandingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StandingsBloc, StandingsState>(
      builder: (context, state) {
        if (state is StandingsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StandingsLoaded) {
          return _buildStandingsTable(state.standings.response[0]);
        } else if (state is StandingsError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildStandingsTable(League league) {
    final statusColors = _getUniqueStatusColors(league.standings);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            league.name,
            style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Table(
          columnWidths: const {
            0: FixedColumnWidth(45), // Rank + Status Color
            1: FlexColumnWidth(1), // Team
            2: FixedColumnWidth(25), // P
            3: FixedColumnWidth(25), // W
            4: FixedColumnWidth(25), // D
            5: FixedColumnWidth(25), // L
            6: FixedColumnWidth(25), // GD
            7: FixedColumnWidth(30), // PT
          },
          children: [
            TableRow(
              children: [
                _buildTableHeader('TEAM'),
                _buildTableHeader(''),
                _buildTableHeader('P'),
                _buildTableHeader('W'),
                _buildTableHeader('D'),
                _buildTableHeader('L'),
                _buildTableHeader('GD'),
                _buildTableHeader('PT'),
              ],
            ),
            ...league.standings.map((standing) => _buildTableRow(standing)).toList(),
          ],
        ),
        SizedBox(height: 20),
        _buildLegend(statusColors),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey[400]),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildTableRow(Standing standing) {
    return TableRow(
      children: [
        _buildRankWithStatusColor(standing),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Image.network(standing.team.logo, width: 24, height: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  standing.team.name,
                  style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        _buildTableCell(standing.all.played.toString(), fontWeight: FontWeight.w300),
        _buildTableCell(standing.all.win.toString(), fontWeight: FontWeight.w300),
        _buildTableCell(standing.all.draw.toString(), fontWeight: FontWeight.w300),
        _buildTableCell(standing.all.lose.toString(), fontWeight: FontWeight.w300),
        _buildTableCell(standing.goalsDiff.toString(), fontWeight: FontWeight.w300),
        _buildTableCell(standing.points.toString(), fontWeight: FontWeight.bold, color: Colors.black),
      ],
    );
  }

  Widget _buildRankWithStatusColor(Standing standing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: 20,
            color: _getStatusColor(standing.description),
          ),
          SizedBox(width: 4),
          Text(
            standing.rank.toString(),
            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {FontWeight fontWeight = FontWeight.normal, Color color = Colors.blueGrey}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 14, fontWeight: fontWeight, color: color),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _getStatusColor(String? description) {
    if (description == null) return Colors.transparent;
    if (description.toLowerCase().contains('champions league')) return Colors.blue;
    if (description.toLowerCase().contains('europa league')) return Colors.orange;
    if (description.toLowerCase().contains('conference league')) return Colors.green;
    if (description.toLowerCase().contains('relegation')) return Colors.red;
    if (description.toLowerCase().contains('promotion')) return Colors.green;
    return Colors.grey; // For any other status
  }

  Map<String, Color> _getUniqueStatusColors(List<Standing> standings) {
    final statusColors = <String, Color>{};
    for (var standing in standings) {
      if (standing.description != null && standing.description!.isNotEmpty) {
        statusColors[standing.description!] = _getStatusColor(standing.description);
      }
    }
    return statusColors;
  }

  Widget _buildLegend(Map<String, Color> statusColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...statusColors.entries.map((entry) => _buildLegendItem(entry.value, entry.key)),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
