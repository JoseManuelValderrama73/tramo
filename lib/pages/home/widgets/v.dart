import 'package:flutter/material.dart';

class Velocidad extends StatefulWidget {
  const Velocidad({super.key, required this.v});
  final int? v;

  @override
  State<Velocidad> createState() => _VelocidadState();
}

class _VelocidadState extends State<Velocidad> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(widget.v != null ? widget.v.toString() : '-',
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 80)));
  }
}
