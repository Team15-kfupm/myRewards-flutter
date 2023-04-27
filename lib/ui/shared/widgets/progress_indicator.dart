import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // This widget disables touch on the rest of the screen
        IgnorePointer(
          ignoring: false,
          child: Container(
            color: Colors.black26,
          ),
        ),
        // This widget shows a white background and a progress indicator
        Center(
          child: Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20.0),
                Text('Loading...'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
