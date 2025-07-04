import 'package:flutter/cupertino.dart';

class MapImg extends StatefulWidget {
  const MapImg({super.key});

  @override
  State<MapImg> createState() => _MapImgState();
}

class _MapImgState extends State<MapImg> {
  @override
  Widget build(BuildContext context) {
    return Container(color: CupertinoColors.activeBlue);
  }
}
