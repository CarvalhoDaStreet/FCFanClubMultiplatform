class Gallery {
  final int id;
  final String title;
  final DateTime publishingDate;
  final List<Photo> photos;

  Gallery({
    required this.id,
    required this.title,
    required this.publishingDate,
    required this.photos,
  });
}

class Photo {
  final int id;
  final String url;
  final int width;
  final int height;

  Photo({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });
}
