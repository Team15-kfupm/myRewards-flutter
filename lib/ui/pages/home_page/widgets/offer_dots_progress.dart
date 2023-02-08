import 'package:flutter/material.dart';

class OfferDotsProgress extends StatefulWidget {
  const OfferDotsProgress({Key? key}) : super(key: key);

  @override
  State<OfferDotsProgress> createState() => _OfferDotsProgressState();
}

class _OfferDotsProgressState extends State<OfferDotsProgress> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
