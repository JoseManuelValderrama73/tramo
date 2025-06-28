import 'package:flutter/material.dart';

class VelocidadAvg extends StatefulWidget {
  const VelocidadAvg({super.key, required this.v});
  final double? v;

  @override
  State<VelocidadAvg> createState() => _VelocidadAvgState();
}

class _VelocidadAvgState extends State<VelocidadAvg> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('AVG'),
          const SizedBox(width: 7),
          Text(
            widget.v != null ? widget.v!.toStringAsFixed(1) : '-',
            style: const TextStyle(fontSize: 35),
          ),
        ],
      ),
    );
  }
}
