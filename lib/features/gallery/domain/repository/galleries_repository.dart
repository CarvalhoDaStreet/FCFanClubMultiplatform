import 'package:fc_fan_club/data_state.dart';
import 'package:fc_fan_club/features/gallery/domain/entities/gallery.dart';

abstract class GalleriesRepository {
  Future<DataState<List<Gallery>>> getGalleries();
}
