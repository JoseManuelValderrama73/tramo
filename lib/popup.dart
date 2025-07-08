import 'package:flutter/cupertino.dart';
import 'package:tramo/constants.dart';

class PopupButton extends StatelessWidget {
  const PopupButton({
    super.key,
    required this.color,
    required this.txt,
    required this.onTap,
  });
  final CupertinoDynamicColor color;
  final String txt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color.withOpacity(.8),
          border: Border.all(width: 3, color: color),
        ),
        child: Text(txt),
      ),
    );
  }
}

class Popup extends StatelessWidget {
  const Popup({
    super.key,
    required this.color,
    this.padding,
    required this.title,
    required this.widgets,
    required this.buttons,
  });

  final CupertinoDynamicColor color;
  final EdgeInsets? padding;
  final String title;
  final List<Widget> widgets;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(.9),
        border: Border.all(width: 3, color: color),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: titleStyle.copyWith(fontSize: 30)),
          SizedBox(height: 10),
          Column(children: widgets),
          const SizedBox(height: 20),
          Row(
            spacing: 35,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons,
          ),
        ],
      ),
    );
  }
}
