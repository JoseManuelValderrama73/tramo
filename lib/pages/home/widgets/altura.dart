import 'package:flutter/cupertino.dart';

class Altura extends StatefulWidget {
  const Altura({super.key, required this.a});
  final int? a;

  @override
  State<Altura> createState() => _AlturaState();
}

class _AlturaState extends State<Altura> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          const Text('ALTITUD'),
          const SizedBox(width: 7),
          Text(widget.a != null ? widget.a.toString() : '-',
              style: const TextStyle(fontSize: 35))
        ]));
  }
}
