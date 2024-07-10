import 'package:fc_fan_club/features/news/domain/entities/news.dart';
import 'package:flutter/material.dart';

class NewsItemWidget extends StatelessWidget {
  final News news;

  const NewsItemWidget({required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network("http://localhost:1337${news.thumbUrl}"),
        title: Text(news.title),
        subtitle: Text(news.description),
      ),
    );
  }
}
