import 'package:fc_fan_club/features/news/presentation/bloc/news_bloc.dart';
import 'package:fc_fan_club/features/news/presentation/widgets/news_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatelessWidget {
  final int pageSize = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: BlocProvider(
        create: (context) => NewsBloc(RepositoryProvider.of(context))..add(FetchNews(page: 1, pageSize: pageSize)),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  return NewsItemWidget(news: state.news[index]);
                },
              );
            } else if (state is NewsError) {
              return Center(child: Text('Failed to fetch news'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
