import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/gallery/domain/entities/gallery.dart';

class GalleryModel extends Gallery {
  GalleryModel({
    required int id,
    required String title,
    required DateTime publishingDate,
    required List<PhotoModel> photos,
  }) : super(
          id: id,
          title: title,
          publishingDate: publishingDate,
          photos: photos,
        );

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'],
      title: json['attributes']['title'],
      publishingDate: DateTime.parse(json['attributes']['publishingDate']),
      photos: (json['attributes']['photos']['data'] as List).map((photo) => PhotoModel.fromJson(photo)).toList(),
    );
  }
}

class PhotoModel extends Photo {
  PhotoModel({
    required int id,
    required String url,
    required int width,
    required int height,
  }) : super(
          id: id,
          url: url,
          width: width,
          height: height,
        );

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      url: AppConfig.strapiBaseUrl + json['attributes']['url'],
      width: json['attributes']['width'],
      height: json['attributes']['height'],
    );
  }
}
