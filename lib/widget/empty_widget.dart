import 'package:flutter/material.dart';
import 'package:gallery_of_photo/util/app_images.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FractionallySizedBox(
            alignment: Alignment.center,
            child: Image.asset(AppImages.placeholder),
          ),
          const SizedBox(height: 20),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
