import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FractionallySizedBox(
            alignment: Alignment.center,
            child: Text("Loading image..."),
          ),
          SizedBox(height: 20),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
