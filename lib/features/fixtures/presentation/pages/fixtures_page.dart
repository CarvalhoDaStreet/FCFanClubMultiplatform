import 'package:fc_fan_club/features/fixtures/domain/usecases/get_fixtures_usecase.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_bloc.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_state.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/results_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/standings_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/widgets/fixture_item_widget.dart';
import 'package:fc_fan_club/features/fixtures/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FixturesPage extends StatelessWidget {
  final int next = 50;

  const FixturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[350],
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    TabItem(title: 'Fixtures'),
                    TabItem(title: 'Results'),
                    TabItem(title: 'Standings'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: TabBarView(
            children: [
              const FixturesTab(),
              ResultsTab(),
              StandingsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class FixturesTab extends StatelessWidget {
  final int next = 50;

  const FixturesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FixturesBloc(context.read<GetFixturesUseCase>())..add(LoadFixturesEvent(next)),
      child: BlocBuilder<FixturesBloc, FixturesState>(
        builder: (context, state) {
          if (state is FixturesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FixturesLoaded) {
            return ListView.builder(
              itemCount: state.fixtures.length,
              itemBuilder: (context, index) {
                return FixtureItemWidget(fixture: state.fixtures[index]);
              },
            );
          } else if (state is FixturesError) {
            return const Center(child: Text('Failed to fetch fixtures'));
          }
          return Container();
        },
      ),
    );
  }
}
