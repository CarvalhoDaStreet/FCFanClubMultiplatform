import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubstitutionEventWidget extends StatelessWidget {
  final dynamic event;
  final bool isHomeTeamEvent;

  const SubstitutionEventWidget({Key? key, required this.event, required this.isHomeTeamEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isHomeTeamEvent ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isHomeTeamEvent) ...[
          const Column(
            children: [
              Icon(Icons.arrow_forward, color: Colors.green), // Player in
              Icon(Icons.arrow_back, color: Colors.red), // Player out
            ],
          ),
          const SizedBox(width: 8),
        ],
        Column(
          crossAxisAlignment: isHomeTeamEvent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              isHomeTeamEvent ? '${event.time.elapsed}\' ${event.assist?.name ?? 'Unknown'}' : '${event.assist?.name ?? 'Unknown'} ${event.time.elapsed}\'',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              '${event.player.name ?? 'Unknown'}',
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        if (!isHomeTeamEvent) ...[
          const SizedBox(width: 8),
          const Column(
            children: [
              Icon(Icons.arrow_forward, color: Colors.green), // Player in
              Icon(Icons.arrow_back, color: Colors.red), // Player out
            ],
          ),
        ],
      ],
    );
  }
}
