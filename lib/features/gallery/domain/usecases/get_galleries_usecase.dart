import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gallery/domain/entities/gallery.dart';
import 'package:fc_fan_club/features/gallery/domain/repository/galleries_repository.dart';

class GetGalleriesUseCase {
  final GalleriesRepository galleriesRepository;

  GetGalleriesUseCase(this.galleriesRepository);

  Future<DataState<List<Gallery>>> call() {
    return galleriesRepository.getGalleries();
  }
}
