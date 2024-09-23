import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardEventWidget extends StatelessWidget {
  final dynamic event;
  final bool isHomeTeamEvent;

  const CardEventWidget({super.key, required this.event, required this.isHomeTeamEvent});

  @override
  Widget build(BuildContext context) {
    Icon cardIcon;
    if (event.detail == 'Yellow Card') {
      cardIcon = const Icon(Icons.square, color: Colors.yellow);
    } else if (event.detail == 'Red Card') {
      cardIcon = const Icon(Icons.square, color: Colors.red);
    } else {
      cardIcon = const Icon(Icons.square, color: Colors.grey);
    }

    return Row(
      mainAxisAlignment: isHomeTeamEvent ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isHomeTeamEvent) ...[
          cardIcon,
          const SizedBox(width: 8),
        ],
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: isHomeTeamEvent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              isHomeTeamEvent ? '${event.time.elapsed}\' ${event.player.name}' : '${event.player.name} ${event.time.elapsed}\'',
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
          cardIcon,
        ],
      ],
    );
  }
}
