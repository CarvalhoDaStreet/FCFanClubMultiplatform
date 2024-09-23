import 'package:fc_fan_club/features/gameEvents/presentation/bloc/game_events_bloc.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/bloc/game_events_state.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/widgets/event_type_cards/cards_event_widget.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/widgets/event_type_cards/default_event_widget.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/widgets/event_type_cards/goal_event_widget.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/widgets/event_type_cards/subst_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GameEventsWidget extends StatelessWidget {
  final int homeTeamId;
  final int awayTeamId;

  const GameEventsWidget({super.key, required this.homeTeamId, required this.awayTeamId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEventsBloc, GameEventsState>(
      builder: (context, state) {
        if (state is GameEventsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GameEventsLoaded) {
          if (state.gameEvents.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.sports_soccer_rounded, color: Colors.grey, size: 50),
                const SizedBox(height: 20),
                Text(
                  'No game events available yet',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.gameEvents.length,
              itemBuilder: (context, index) {
                final event = state.gameEvents[index];
                final bool isHomeTeamEvent = event.team.id == homeTeamId;
                Widget eventWidget;

                if (event.type == 'Goal') {
                  eventWidget = GoalEventWidget(event: event, isHomeTeamEvent: isHomeTeamEvent);
                } else if (event.type == 'Card') {
                  eventWidget = CardEventWidget(event: event, isHomeTeamEvent: isHomeTeamEvent);
                } else if (event.type == 'subst') {
                  eventWidget = SubstitutionEventWidget(event: event, isHomeTeamEvent: isHomeTeamEvent);
                } else {
                  eventWidget = DefaultEventWidget(event: event, isHomeTeamEvent: isHomeTeamEvent);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Align(
                    alignment: isHomeTeamEvent ? Alignment.centerLeft : Alignment.centerRight,
                    child: eventWidget,
                  ),
                );
              },
            );
          }
        } else if (state is GameEventsError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
