import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_of_photo/domain/entity/photo_entity.dart';
import 'package:gallery_of_photo/domain/entity/photos_state_entity.dart';
import 'package:gallery_of_photo/widget/photos_indicator.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.initState});

  final PhotosStateEntity initState;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final PageController pageController;
  late double _currentPageValue;

  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: widget.initState.indexInitPhoto, viewportFraction: 0.8)
      ..addListener(_listenToPageController);
    _currentPageValue = widget.initState.indexInitPhoto.toDouble();
  }

  @override
  void dispose() {
    pageController
      ..removeListener(_listenToPageController)
      ..dispose();
    super.dispose();
  }

  void _listenToPageController() {
    double page = pageController.page ?? 0;

    setState(() {
      _currentPageValue = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.initState.photos;
    const sumPading = 40 + 72;
    final heightPageView =
        MediaQuery.sizeOf(context).height - kToolbarHeight - sumPading;
    return Scaffold(
      appBar: AppBar(
        leading: const _BackButton(),
        actions: [
          PhotosIndicator(
            numberOfPhotos: photos.length,
            numberCurrentPhoto: _currentPageValue.round() + 1,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 72),
        child: PageView.builder(
            controller: pageController,
            itemCount: widget.initState.photos.length,
            itemBuilder: (_, index) {
              final photo = photos[index];
              Matrix4 matrix = Matrix4.identity();
              var scale = 0.8;

              if (index == _currentPageValue.floor() ||
                  index == _currentPageValue.floor() + 1 ||
                  index == _currentPageValue.floor() - 1) {
                scale =
                    1 - (_currentPageValue - index).abs() * (1 - _scaleFactor);
              }

              var transform = heightPageView * (1 - scale) / 2;
              matrix = Matrix4.diagonal3Values(1, scale, 1)
                ..setTranslationRaw(0, transform, 0);

              return Transform(
                transform: matrix,
                child: _FullPhotoScreen(
                  photo: photo,
                  tag: index == _currentPageValue.floor()
                      ? photo.imageUrl
                      : null,
                ),
              );
            }),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }
}

class _FullPhotoScreen extends StatelessWidget {
  const _FullPhotoScreen({Key? key, required this.photo, required this.tag})
      : super(key: key);

  final PhotoEntity photo;

  final String? tag;

  @override
  Widget build(BuildContext context) {
    final imageWidget = CachedNetworkImage(
      imageUrl: photo.imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(
        value: downloadProgress.progress,
      ),
      errorWidget: (contex, url, error) => const Icon(Icons.error),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 1 / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: tag == null
              ? imageWidget
              : Hero(
                  tag: photo.imageUrl,
                  child: imageWidget,
                ),
        ),
      ),
    );
  }
}
