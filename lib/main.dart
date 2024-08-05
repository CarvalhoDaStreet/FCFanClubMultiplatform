import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_event.dart';
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
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_bloc.dart';

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
