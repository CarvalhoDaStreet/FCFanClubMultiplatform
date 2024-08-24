import 'package:equatable/equatable.dart';

abstract class GalleriesEvent extends Equatable {
  const GalleriesEvent();

  @override
  List<Object> get props => [];
}

class LoadGalleriesEvent extends GalleriesEvent {}
