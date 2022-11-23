import 'package:flutter/material.dart';

class StoreLogo extends StatelessWidget {
  const StoreLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child: Text('Store Logo')),
    );
  }
}
