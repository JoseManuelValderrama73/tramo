import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Hora extends StatefulWidget {
  const Hora({super.key});

  @override
  State<Hora> createState() => _HoraState();
}

class _HoraState extends State<Hora> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Center(
            child: Text(DateFormat('hh:mm').format(DateTime.now()),
                style: const TextStyle(fontSize: 25)));
      },
    );
  }
}
