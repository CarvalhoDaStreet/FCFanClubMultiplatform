import 'package:fc_fan_club/features/gameEvents/presentation/bloc/game_events_bloc.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/bloc/game_events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalScorersWidget extends StatelessWidget {
  final int teamId;

  const GoalScorersWidget({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEventsBloc, GameEventsState>(
      builder: (context, state) {
        if (state is GameEventsLoaded) {
          final goalScorers = state.gameEvents
              .where((event) => event.type == 'Goal' && event.team.id == teamId)
              .map((event) => '${event.player.name}, ${event.time.elapsed}\'') // Include the minute in the format "Player Name (Minute')"
              .toList();

          if (goalScorers.isEmpty) {
            return Text(
              '',
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: goalScorers
                  .map((scorer) => Text(
                        scorer,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ))
                  .toList(),
            );
          }
        } else {
          return Container(); // Or some other placeholder while loading
        }
      },
    );
  }
}
