import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/gallery/domain/entities/gallery.dart';

abstract class GalleriesState extends Equatable {
  const GalleriesState();

  @override
  List<Object> get props => [];
}

class GalleriesInitial extends GalleriesState {}

class GalleriesLoading extends GalleriesState {}

class GalleriesLoaded extends GalleriesState {
  final List<Gallery> galleries;

  const GalleriesLoaded(this.galleries);

  @override
  List<Object> get props => [galleries];
}

class GalleriesError extends GalleriesState {
  final String message;

  const GalleriesError(this.message);

  @override
  List<Object> get props => [message];
}
