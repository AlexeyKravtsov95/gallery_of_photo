import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_of_photo/domain/entity/photo_entity.dart';
import 'package:gallery_of_photo/domain/entity/photos_state_entity.dart';
import 'package:gallery_of_photo/presentation/detail_screen.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget(
      {super.key, required this.indexSelectedPhoto, required this.photosList});

  final int indexSelectedPhoto;
  final List<PhotoEntity> photosList;

  void _onTap(BuildContext context, {required int indexInitPhoto}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => DetailScreen(
            initState: PhotosStateEntity(
                indexInitPhoto: indexInitPhoto, photos: photosList))));
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = photosList[indexSelectedPhoto].imageUrl;

    return Center(
        child: GestureDetector(
      onTap: () => _onTap(context, indexInitPhoto: indexSelectedPhoto),
      child: AspectRatio(
        aspectRatio: 1,
        child: Hero(
          tag: imageUrl,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    ));
  }
}
