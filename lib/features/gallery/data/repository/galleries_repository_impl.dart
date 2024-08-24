import 'package:dio/dio.dart';
import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gallery/data/datasources/galleries_api_service.dart';
import 'package:fc_fan_club/features/gallery/domain/entities/gallery.dart';
import 'package:fc_fan_club/features/gallery/domain/repository/galleries_repository.dart';

class GalleriesRepositoryImpl implements GalleriesRepository {
  final GalleriesApiService galleriesApiService;

  GalleriesRepositoryImpl(this.galleriesApiService);

  @override
  Future<DataState<List<Gallery>>> getGalleries() async {
    try {
      final galleries = await galleriesApiService.getGalleries();
      return DataSuccess(galleries);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
