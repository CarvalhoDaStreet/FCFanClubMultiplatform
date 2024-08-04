import 'package:fc_fan_club/features/news/presentation/bloc/news_bloc.dart';
import 'package:fc_fan_club/features/news/presentation/widgets/news_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatelessWidget {
  final int pageSize = 25;

  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'News',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NewsLoaded) {
                return ListView.separated(
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      return Padding(padding: const EdgeInsets.only(bottom: 10), child: NewsItemWidget(news: state.news[index]));
                    },
                    separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black, Colors.transparent],
                                stops: [0, 0, 0.95],
                              ),
                            ),
                          ),
                        ));
              } else if (state is NewsError) {
                return const Center(child: Text('Failed to fetch news'));
              }
              return Container();
            },
          ),
        ));
  }
}
