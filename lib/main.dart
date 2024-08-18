import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures/fixtures_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_bloc.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_event.dart';
import 'package:fc_fan_club/features/gameEvents/data/datasources/game_events_api_service.dart';
import 'package:fc_fan_club/features/gameEvents/data/repository/game_events_repository_impl.dart';
import 'package:fc_fan_club/features/gameEvents/domain/usecases/get_game_events_usecase.dart';
import 'package:fc_fan_club/features/lineups/data/datasources/lineup_api_service.dart';
import 'package:fc_fan_club/features/lineups/data/repository/lineup_repository_impl.dart';
import 'package:fc_fan_club/features/lineups/domain/usecases/get_lineup_usecase.dart';
import 'package:fc_fan_club/features/lineups/presentation/bloc/lineup_bloc.dart';
import 'package:fc_fan_club/features/stats/data/datasources/stats_api_service.dart';
import 'package:fc_fan_club/features/stats/data/repository/stats_repository_impl.dart';
import 'package:fc_fan_club/features/stats/domain/usecases/get_stats_usecase.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fc_fan_club/features/main/presentation/pages/main_page.dart';
import 'package:fc_fan_club/features/news/data/datasources/news_api_service.dart';
import 'package:fc_fan_club/features/news/data/repository/news_repository_impl.dart';
import 'package:fc_fan_club/features/news/domain/usecases/get_news_usecase.dart';
import 'package:fc_fan_club/features/news/presentation/bloc/news_bloc.dart';
import 'package:fc_fan_club/features/fixtures/data/datasources/fixtures_api_service.dart';
import 'package:fc_fan_club/features/fixtures/data/repository/fixtures_repository_impl.dart';
import 'package:fc_fan_club/features/fixtures/domain/usecases/get_fixtures_usecase.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures/fixtures_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => Dio()),
        RepositoryProvider(
          create: (context) => NewsApiService(RepositoryProvider.of<Dio>(context)),
        ),
        RepositoryProvider(
          create: (context) => NewsRepositoryImpl(RepositoryProvider.of<NewsApiService>(context)),
        ),
        RepositoryProvider(
          create: (context) => GetNewsUseCase(RepositoryProvider.of<NewsRepositoryImpl>(context)),
        ),
        RepositoryProvider(
          create: (context) => FixturesApiService(RepositoryProvider.of<Dio>(context)),
        ),
        RepositoryProvider(
          create: (context) => FixturesRepositoryImpl(RepositoryProvider.of<FixturesApiService>(context)),
        ),
        RepositoryProvider(
          create: (context) => GetFixturesUseCase(RepositoryProvider.of<FixturesRepositoryImpl>(context)),
        ),
        RepositoryProvider(
          create: (context) => GameEventsApiService(RepositoryProvider.of<Dio>(context)),
        ),
        RepositoryProvider(
          create: (context) => GameEventsRepositoryImpl(RepositoryProvider.of<GameEventsApiService>(context)),
        ),
        RepositoryProvider(
          create: (context) => GetGameEventsUsecase(RepositoryProvider.of<GameEventsRepositoryImpl>(context)),
        ),
        RepositoryProvider(
          create: (context) => FootballStatisticsApiService(RepositoryProvider.of<Dio>(context)),
        ),
        RepositoryProvider(
          create: (context) => FootballStatisticsRepositoryImpl(RepositoryProvider.of<FootballStatisticsApiService>(context)),
        ),
        RepositoryProvider(
          create: (context) => GetFootballStatisticsUseCase(RepositoryProvider.of<FootballStatisticsRepositoryImpl>(context)),
        ),
        RepositoryProvider(
          create: (context) => LineupsApiService(RepositoryProvider.of<Dio>(context)),
        ),
        RepositoryProvider(
          create: (context) => LineupsRepositoryImpl(RepositoryProvider.of<LineupsApiService>(context)),
        ),
        RepositoryProvider(
          create: (context) => GetLineupsUseCase(RepositoryProvider.of<LineupsRepositoryImpl>(context)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsBloc(
              RepositoryProvider.of<GetNewsUseCase>(context),
            )..add(const FetchNews(page: 1, pageSize: 25)),
          ),
          BlocProvider(
            create: (context) => FixturesBloc(
              RepositoryProvider.of<GetFixturesUseCase>(context),
            )..add(const LoadFixturesEvent(50)),
          ),
          BlocProvider(
            create: (context) => ResultsBloc(
              RepositoryProvider.of<GetFixturesUseCase>(context),
            )..add(const LoadResultsEvent(50)),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Clean Architecture',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: MainPage(),
          debugShowCheckedModeBanner: false, // Hide the debug banner
        ),
      ),
    );
  }
}
