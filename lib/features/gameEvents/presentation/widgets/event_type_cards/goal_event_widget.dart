import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalEventWidget extends StatelessWidget {
  final dynamic event;
  final bool isHomeTeamEvent;

  const GoalEventWidget({Key? key, required this.event, required this.isHomeTeamEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isHomeTeamEvent ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isHomeTeamEvent) ...[
          const Icon(Icons.sports_soccer, color: Colors.black),
          const SizedBox(width: 8),
        ],
        Column(
          crossAxisAlignment: isHomeTeamEvent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              '${event.time.elapsed}\' ${event.player.name}',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              event.detail,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        if (!isHomeTeamEvent) ...[
          const SizedBox(width: 8),
          const Icon(Icons.sports_soccer, color: Colors.black),
        ],
      ],
    );
  }
}
