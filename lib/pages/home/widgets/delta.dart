import 'package:flutter/cupertino.dart';

class Delta extends StatefulWidget {
  const Delta({super.key});

  @override
  State<Delta> createState() => _DeltaState();
}

String getStr(double delta) {
  String d = delta.toString();
  switch (d.length) {
    case 1:
      d = '$d.00';
      break;
    case 3:
      d = '${d}0';
      break;
  }
  return d;
}

class _DeltaState extends State<Delta> {
  double delta = 0;
  @override
  Widget build(BuildContext context) {
    String d = getStr(delta);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('DELTA'),
          const SizedBox(width: 7),
          delta < 0
              ? Text(
                  d.toString(),
                  style: const TextStyle(
                    fontSize: 55,
                    color: CupertinoColors.destructiveRed,
                  ),
                )
              : Text(
                  '+$d',
                  style: const TextStyle(
                    fontSize: 55,
                    color: CupertinoColors.activeGreen,
                  ),
                ),
        ],
      ),
    );
  }
}
