import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FixtureDetailPage extends StatelessWidget {
  final Fixtures fixture;

  const FixtureDetailPage({required this.fixture});

  @override
  Widget build(BuildContext context) {
    // Parse the date string
    DateTime parsedDate = DateTime.parse(fixture.date);

    // Get the system locale
    String systemLocale = Localizations.localeOf(context).toString();

    // Format the date based on the system locale
    DateFormat dateFormat = DateFormat('E.d MMM - HH:mm', systemLocale);
    String formattedDate = dateFormat.format(parsedDate);
    String gameDate = formattedDate;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          fixture.league,
          textAlign: TextAlign.left,
          maxLines: 1,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100, // Set a fixed width for both team columns
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(fixture.homeTeamLogo, width: 50, height: 50),
                      const SizedBox(height: 15),
                      Text(
                        fixture.homeTeam,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      gameDate,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        print('Adicionado ao calendário TODO');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconColor: Colors.grey,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 20),
                            Icon(Icons.calendar_month, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100, // Set the same fixed width for both team columns
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(fixture.awayTeamLogo, width: 50, height: 50),
                      const SizedBox(height: 15),
                      Text(
                        fixture.awayTeam,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                fixture.venue,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ),
            const Divider(color: Colors.black, thickness: 1),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.sports_soccer_rounded, color: Colors.grey, size: 50),
                const SizedBox(height: 20),
                Text(
                  'No game information available yet',
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
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
