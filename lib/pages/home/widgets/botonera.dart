import 'package:flutter/cupertino.dart';

class Boton extends StatefulWidget {
  const Boton(
      {super.key,
      required this.ontap,
      required this.color,
      required this.icon});
  final Function ontap;
  final CupertinoDynamicColor color;
  final IconData icon;

  @override
  State<Boton> createState() => _BotonState();
}

class _BotonState extends State<Boton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.ontap(),
        child: Container(
            height: 70,
            color: widget.color,
            child: Icon(widget.icon, size: 30)));
  }
}
