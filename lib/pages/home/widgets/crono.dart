import 'package:flutter/cupertino.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';

class Crono extends StatefulWidget {
  const Crono({super.key, required this.seconds});
  final Stream<int> seconds;

  @override
  State<Crono> createState() => _CronoState();
}

class _CronoState extends State<Crono> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: widget.seconds,
        initialData: 0,
        builder: (context, snp) {
          final s = snp.data;
          if (s == null) {
            return const CupertinoActivityIndicator();
          } else {
            return Center(
                child: Text(StopWatchTimer.getDisplayTime(s),
                    style: const TextStyle(fontSize: 25)));
          }
        });
  }
}
