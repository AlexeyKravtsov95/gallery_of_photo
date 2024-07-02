import 'package:flutter/material.dart';
import 'package:gallery_of_photo/domain/entity/photo_entity.dart';
import 'package:gallery_of_photo/main.dart';
import 'package:gallery_of_photo/util/app_images.dart';
import 'package:gallery_of_photo/widget/empty_widget.dart';
import 'package:gallery_of_photo/widget/loading_widget.dart';
import 'package:gallery_of_photo/widget/photo_widget.dart';
import 'package:union_state/union_state.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final screenState = UnionStateNotifier<List<PhotoEntity>>.loading();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final data = await photosRepository.getPhotos();
      screenState.content(data);
    } on Exception catch (e) {
      screenState.failure(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(AppImages.logo),
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
        ),
        body: UnionStateListenableBuilder<List<PhotoEntity>>(
          unionStateListenable: screenState,
          loadingBuilder: (_, __) => const LoadingWidget(),
          builder: (_, state) => state.isNotEmpty
              ? _ContentWidget(data: state)
              : const EmptyWidget(),
          failureBuilder: (_, __, ___) => ErrorWidget('Something wrong...'),
        ));
  }
}

class _ContentWidget extends StatelessWidget {
  final List<PhotoEntity> data;

  const _ContentWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 5,
          crossAxisSpacing: 3),
      itemCount: data.length,
      itemBuilder: (_, i) => PhotoWidget(
        indexSelectedPhoto: i,
        photosList: data,
      ),
    );
  }
}
