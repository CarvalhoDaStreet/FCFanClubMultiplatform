import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:fc_fan_club/features/fixtures/domain/usecases/get_fixtures_usecase.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_bloc.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/fixtures_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/results_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/standings_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FixturesPage extends StatefulWidget {
  const FixturesPage({super.key});

  @override
  _FixturesPageState createState() => _FixturesPageState();
}

class _FixturesPageState extends State<FixturesPage> with WidgetsBindingObserver {
  late FixturesBloc _fixturesBloc;
  List<Fixtures> _cachedFixtures = [];
  bool _isFixturesLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fixturesBloc = FixturesBloc(context.read<GetFixturesUseCase>());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _fixturesBloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _clearCache();
    }
  }

  void _clearCache() {
    setState(() {
      _cachedFixtures = [];
      _isFixturesLoaded = false;
    });
  }

  void _loadFixtures() {
    if (!_isFixturesLoaded) {
      _fixturesBloc.add(LoadFixturesEvent(50));
    }
  }

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
              FixturesTab(
                bloc: _fixturesBloc,
                cachedFixtures: _cachedFixtures,
                isFixturesLoaded: _isFixturesLoaded,
                onFixturesLoaded: (fixtures) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _cachedFixtures = fixtures;
                      _isFixturesLoaded = true;
                    });
                  });
                },
              ),
              ResultsTab(),
              StandingsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
