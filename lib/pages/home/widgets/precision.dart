import 'package:flutter/cupertino.dart';

import 'package:tramo/constants.dart';

class Precision extends StatefulWidget {
  const Precision({super.key, required this.p});
  final double? p;

  @override
  State<Precision> createState() => _PrecisionState();
}

class _PrecisionState extends State<Precision> {
  @override
  Widget build(BuildContext context) {
    Color colorTexto = CupertinoColors.white;
    if (widget.p != null) {
      if (widget.p! == 0.0) {
        colorTexto = CupertinoColors.systemGrey2;
      } else if (widget.p! <= limitePrecisionBuena) {
        colorTexto = CupertinoColors.activeGreen;
      } else if (widget.p! <= limitePrecisionRegular) {
        colorTexto = CupertinoColors.systemOrange;
      } else {
        colorTexto = CupertinoColors.destructiveRed;
      }
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('GPS ACC'),
          const SizedBox(width: 7),
          Text(
            widget.p != null ? widget.p.toString() : '-',
            style: TextStyle(fontSize: 35, color: colorTexto),
          ),
        ],
      ),
    );
  }
}
