import 'package:fc_fan_club/features/main/presentation/pages/main_page.dart';
import 'package:fc_fan_club/features/news/data/datasources/news_api_service.dart';
import 'package:fc_fan_club/features/news/data/repository/news_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fc_fan_club/features/news/domain/usecases/get_news_usecase.dart';
import 'package:fc_fan_club/features/news/presentation/bloc/news_bloc.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsBloc(
              RepositoryProvider.of<GetNewsUseCase>(context),
            )..add(const FetchNews(page: 1, pageSize: 25)),
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
