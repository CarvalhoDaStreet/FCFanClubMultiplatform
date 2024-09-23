import 'package:fc_fan_club/features/lineups/domain/entities/lineup.dart';
import 'package:fc_fan_club/features/lineups/presentation/bloc/lineup_bloc.dart';
import 'package:fc_fan_club/features/lineups/presentation/bloc/lineup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LineupsWidget extends StatelessWidget {
  final int fixtureId;

  const LineupsWidget({super.key, required this.fixtureId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineupsBloc, LineupsState>(
      builder: (context, state) {
        if (state is LineupsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LineupsLoaded) {
          if (state.lineups.response.isEmpty) {
            return _buildPlaceholder();
          }
          return _buildLineups(context, state.lineups);
        } else if (state is LineupsError) {
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
          Icon(Icons.sports_soccer, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Lineup information not available',
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

  Widget _buildLineups(BuildContext context, Lineups lineups) {
    final homeTeam = lineups.response[0];
    final awayTeam = lineups.response[1];
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFormations(homeTeam, awayTeam),
          const SizedBox(height: 20),
          _buildSubstitutes(homeTeam, awayTeam),
        ],
      ),
    );
  }

  Widget _buildFormations(TeamLineup homeTeam, TeamLineup awayTeam) {
    return Container(
      height: 600, // Increased height to accommodate both teams
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: CustomPaint(
        painter: SoccerFieldPainter(),
        child: Column(
          children: [
            Expanded(child: _buildTeamFormation(homeTeam, isHome: true)),
            Expanded(child: _buildTeamFormation(awayTeam, isHome: false)),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamFormation(TeamLineup team, {required bool isHome}) {
    final formationRows = team.formation.split('-').map(int.parse).toList();
    formationRows.insert(0, 1); // Add goalkeeper

    List<List<Player>> organizedPlayers = [
      [team.startXI.first], // Goalkeeper
    ];

    int currentIndex = 1;
    for (int playersInRow in formationRows.skip(1)) {
      organizedPlayers.add(
        team.startXI.sublist(currentIndex, currentIndex + playersInRow),
      );
      currentIndex += playersInRow;
    }

    if (!isHome) {
      organizedPlayers = organizedPlayers.reversed.toList();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: organizedPlayers.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((player) => _buildPlayerItem(player)).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildSubstitutes(TeamLineup homeTeam, TeamLineup awayTeam) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Substitutes',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...homeTeam.substitutes.map((player) => _buildSubstituteItem(player, isHome: true)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...awayTeam.substitutes.map((player) => _buildSubstituteItem(player, isHome: false)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlayerItem(Player player) {
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.shirt, size: 28, color: Colors.black),
              Positioned(
                top: 6,
                child: Text(
                  player.number.toString(),
                  style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            player.name,
            style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildSubstituteItem(Player player, {required bool isHome}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (isHome) ...[
            _buildSubstituteShirt(player),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              player.name,
              style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            )),
          ] else ...[
            Expanded(
                child: Text(
              player.name,
              style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            )),
            const SizedBox(width: 8),
            _buildSubstituteShirt(player),
          ],
        ],
      ),
    );
  }

  Widget _buildSubstituteShirt(Player player) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const FaIcon(FontAwesomeIcons.shirt, size: 24, color: Colors.black),
        Positioned(
          top: 5,
          child: Text(
            player.number.toString(),
            style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class SoccerFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw outline
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Draw center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 10,
      paint,
    );

    // Draw goalkeeper areas (more rectangular)
    final goalkeeperAreaWidth = size.width * 0.4;
    final goalkeeperAreaHeight = size.height * 0.06;

    // Top goalkeeper area
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - goalkeeperAreaWidth) / 2,
        0,
        goalkeeperAreaWidth,
        goalkeeperAreaHeight,
      ),
      paint,
    );

    // Bottom goalkeeper area
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - goalkeeperAreaWidth) / 2,
        size.height - goalkeeperAreaHeight,
        goalkeeperAreaWidth,
        goalkeeperAreaHeight,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
