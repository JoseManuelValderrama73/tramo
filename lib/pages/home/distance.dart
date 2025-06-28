import 'package:flutter/material.dart';

class Distance extends StatelessWidget {
  const Distance({super.key, required this.dist});
  final double? dist;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DISTANCIA'),
          const SizedBox(width: 7),
          Text(
            dist != null ? dist!.toStringAsFixed(1) : '-',
            style: const TextStyle(fontSize: 35),
          ),
        ],
      ),
    );
  }
}
