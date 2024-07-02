import 'package:flutter/material.dart';

class PhotosIndicator extends StatelessWidget {
  const PhotosIndicator(
      {super.key,
      required this.numberCurrentPhoto,
      required this.numberOfPhotos});

  final int numberCurrentPhoto;
  final int numberOfPhotos;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text.rich(
        TextSpan(
          text: '$numberCurrentPhoto',
          style: themeText?.copyWith(color: Colors.black),
          children: [
            TextSpan(
              text: '/$numberOfPhotos',
              style: themeText?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
