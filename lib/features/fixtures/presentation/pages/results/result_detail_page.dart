import 'package:fc_fan_club/features/gameEvents/presentation/widgets/main/game_events_widget.dart';
import 'package:fc_fan_club/features/gameEvents/presentation/widgets/main/player_who_scored_widget.dart';
import 'package:flutter/material.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ResultDetailPage extends StatelessWidget {
  final Fixtures fixture;

  const ResultDetailPage({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(fixture.date);
    String systemLocale = Localizations.localeOf(context).toString();
    DateFormat dateFormat = DateFormat('EEE d MMM - HH:mm', systemLocale);
    String formattedDate = dateFormat.format(parsedDate);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            fixture.league,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Home team column
                        SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(fixture.homeTeamLogo, width: 40, height: 40),
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
                              const SizedBox(height: 10),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 20,
                                ),
                                child: GoalScorersWidget(teamId: fixture.homeTeamId),
                              ),
                            ],
                          ),
                        ),

                        // Center column for date, goals, and status
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              formattedDate,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  fixture.homeGoals?.toString() ?? 'TBA',
                                  textAlign: TextAlign.right,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  ' - ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  fixture.awayGoals?.toString() ?? 'TBA',
                                  textAlign: TextAlign.right,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            if (fixture.longStatus == 'Match Finished')
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Terminado',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        // Away team column
                        SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(fixture.awayTeamLogo, width: 40, height: 40),
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
                              const SizedBox(height: 10),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 20,
                                ),
                                child: GoalScorersWidget(teamId: fixture.awayTeamId),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
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
                ],
              ),
            ),
            PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[350],
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    padding: const EdgeInsets.all(5),
                    indicator: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: const [
                      Tab(text: 'Events'),
                      Tab(text: 'Stats'),
                      Tab(text: 'Line-ups'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Events tab
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GameEventsWidget(
                      homeTeamId: fixture.homeTeamId,
                      awayTeamId: fixture.awayTeamId,
                    ),
                  ),
                  // Stats tab (placeholder)
                  Center(child: Text('Stats content will go here')),
                  // Line-ups tab (placeholder)
                  Center(child: Text('Line-ups content will go here')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
