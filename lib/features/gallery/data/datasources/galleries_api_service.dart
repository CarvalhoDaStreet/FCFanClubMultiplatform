import 'package:dio/dio.dart';
import 'package:fc_fan_club/config/constants/config.dart';
import 'package:fc_fan_club/features/gallery/data/models/gallery_model.dart';

class GalleriesApiService {
  final Dio dio;

  GalleriesApiService(this.dio);

  Future<List<GalleryModel>> getGalleries() async {
    try {
      final response = await dio.get(
        '${AppConfig.strapiBaseUrl}/api/galleries?populate=*',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConfig.strapiApiKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((item) => GalleryModel.fromJson(item)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      rethrow;
    } catch (e) {
      print('General Exception: $e');
      rethrow;
    }
  }
}
