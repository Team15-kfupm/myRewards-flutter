import 'package:flutter/material.dart';

class OfferProgressBar extends StatefulWidget {
  const OfferProgressBar({Key? key}) : super(key: key);

  @override
  State<OfferProgressBar> createState() => _OfferProgressBarState();
}

class _OfferProgressBarState extends State<OfferProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 180,
          height: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text('80%'),
      ],
    );
  }
}
