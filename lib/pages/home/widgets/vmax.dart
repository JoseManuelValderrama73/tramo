import 'package:flutter/material.dart';

class VelocidadMax extends StatefulWidget {
  const VelocidadMax({super.key, required this.v});
  final int? v;

  @override
  State<VelocidadMax> createState() => _VelocidadMaxState();
}

class _VelocidadMaxState extends State<VelocidadMax> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
          const Text('MAX'),
          const SizedBox(width: 7),
          Text(widget.v != null ? widget.v.toString() : '-',
              style: const TextStyle(fontSize: 40))
        ]));
  }
}
