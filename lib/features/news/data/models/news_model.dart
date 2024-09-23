import 'package:fc_fan_club/features/news/domain/entities/news.dart';

class NewsModel extends News {
  NewsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.publishingDate,
    required super.newsBody,
    required super.authorCredits,
    required super.thumbUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return NewsModel(
      id: json['id'],
      title: attributes['title'],
      description: attributes['description'],
      publishingDate: attributes['publishingDate'],
      newsBody: attributes['newsBody'],
      authorCredits: attributes['authorCredits'],
      thumbUrl: attributes['thumbMedia']['data']['attributes']['formats']['thumbnail']['url'],
    );
  }
}
