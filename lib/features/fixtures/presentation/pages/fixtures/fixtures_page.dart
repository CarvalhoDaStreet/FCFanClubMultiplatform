import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:fc_fan_club/features/fixtures/domain/usecases/get_fixtures_usecase.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures/fixtures_bloc.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures/fixtures_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_bloc.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/fixtures/fixtures_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/results/results_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/standings/standings_tab_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FixturesPage extends StatefulWidget {
  const FixturesPage({super.key});

  @override
  _FixturesPageState createState() => _FixturesPageState();
}

class _FixturesPageState extends State<FixturesPage> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late FixturesBloc _fixturesBloc;
  List<Fixtures> _cachedFixtures = [];
  bool _isFixturesLoaded = false;

  late ResultsBloc _resultsBloc;
  List<Fixtures> _cachedResults = [];
  bool _isResultsLoaded = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fixturesBloc = FixturesBloc(context.read<GetFixturesUseCase>());
    _resultsBloc = ResultsBloc(context.read<GetFixturesUseCase>());
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 1 && !_isResultsLoaded) {
          _loadResults();
        }
      }
    });

    _loadFixtures(); // Load fixtures when the widget is initialized
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _fixturesBloc.close();
    _resultsBloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _clearCache();
    }
  }

  void _clearCache() {
    if (mounted) {
      setState(() {
        _cachedFixtures = [];
        _isFixturesLoaded = false;

        _cachedResults = [];
        _isResultsLoaded = false;
      });
    }
  }

  void _loadFixtures() {
    if (!_isFixturesLoaded) {
      _fixturesBloc.add(const LoadFixturesEvent(50));
    }
  }

  void _loadResults() {
    if (!_isResultsLoaded) {
      _resultsBloc.add(const LoadResultsEvent(50));
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
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
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
            controller: _tabController,
            children: [
              FixturesTab(
                bloc: _fixturesBloc,
                cachedFixtures: _cachedFixtures,
                isFixturesLoaded: _isFixturesLoaded,
                onFixturesLoaded: (fixtures) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && !_isFixturesLoaded) {
                      setState(() {
                        _cachedFixtures = fixtures;
                        _isFixturesLoaded = true;
                      });
                    }
                  });
                },
              ),
              ResultsTab(
                bloc: _resultsBloc,
                cachedResults: _cachedResults,
                isResultsLoaded: _isResultsLoaded,
                onResultsLoaded: (results) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && !_isResultsLoaded) {
                      setState(() {
                        _cachedResults = results;
                        _isResultsLoaded = true;
                      });
                    }
                  });
                },
              ),
              StandingsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
