import 'package:fc_fan_club/features/news/domain/entities/news.dart';

class NewsModel extends News {
  NewsModel({
    required int id,
    required String title,
    required String description,
    required String publishingDate,
    required String newsBody,
    required String authorCredits,
    required String thumbUrl,
  }) : super(
          id: id,
          title: title,
          description: description,
          publishingDate: publishingDate,
          newsBody: newsBody,
          authorCredits: authorCredits,
          thumbUrl: thumbUrl,
        );

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
