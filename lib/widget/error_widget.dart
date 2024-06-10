import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_rounded,
              size: 50,
              color: Colors.orange,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(errorText),
          ],
        ),
      ),
    );
  }
}
