import 'package:flutter/material.dart';
import 'package:gallery_of_photo/data/repository/photos_repository.dart';
import 'package:gallery_of_photo/presentation/photos_screen.dart';

void main() {
  runApp(const MyApp());
}

final photosRepository = PhotosRepository();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postogram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PhotosScreen(),
    );
  }
}
