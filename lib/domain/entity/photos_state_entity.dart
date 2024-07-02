import 'package:gallery_of_photo/domain/entity/photo_entity.dart';

class PhotosStateEntity {
  final int indexInitPhoto;
  final List<PhotoEntity> photos;

  PhotosStateEntity({
    required this.indexInitPhoto,
    required this.photos,
  });
}
