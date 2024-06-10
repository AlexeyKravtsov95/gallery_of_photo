import 'package:gallery_of_photo/data/mock_data.dart';
import 'package:gallery_of_photo/domain/entity/photo_entity.dart';

class PhotosRepository {
  Future<List<PhotoEntity>> getPhotos() async {
    return Future.value(mockData);
  }
}
