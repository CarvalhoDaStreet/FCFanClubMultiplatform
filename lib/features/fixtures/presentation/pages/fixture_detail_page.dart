import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:flutter/material.dart';

class FixtureDetailPage extends StatelessWidget {
  final Fixtures fixture;

  const FixtureDetailPage({required this.fixture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixture Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('League: ${fixture.league}'),
            SizedBox(height: 8),
            Row(
              children: [
                Image.network(fixture.leagueLogo, width: 24, height: 24),
                SizedBox(width: 8),
                Text(fixture.league),
              ],
            ),
            SizedBox(height: 8),
            Text('Date: ${fixture.date}'),
            SizedBox(height: 8),
            Text('Status: ${fixture.status}'),
            SizedBox(height: 8),
            Row(
              children: [
                Image.network(fixture.homeTeamLogo, width: 24, height: 24),
                SizedBox(width: 8),
                Text(fixture.homeTeam),
                SizedBox(width: 16),
                Text('vs'),
                SizedBox(width: 16),
                Text(fixture.awayTeam),
                SizedBox(width: 8),
                Image.network(fixture.awayTeamLogo, width: 24, height: 24),
              ],
            ),
            SizedBox(height: 8),
            Text('Venue: ${fixture.venue}'),
            SizedBox(height: 8),
            Text('Goals: ${fixture.homeGoals} - ${fixture.awayGoals}'),
            SizedBox(height: 8),
            Text('Halftime Score: ${fixture.halftimeScore}'),
            SizedBox(height: 8),
            Text('Fulltime Score: ${fixture.fulltimeScore}'),
            SizedBox(height: 8),
            Text('Extratime Score: ${fixture.extratimeScore}'),
            SizedBox(height: 8),
            Text('Penalty Score: ${fixture.penaltyScore}'),
          ],
        ),
      ),
    );
  }
}
