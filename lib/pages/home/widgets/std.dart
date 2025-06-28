import 'package:flutter/cupertino.dart';

class StdWidget extends StatelessWidget {
  const StdWidget({super.key, required this.desc, required this.data});
  final String desc;
  final int? data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(desc),
          const SizedBox(width: 7),
          Text(
            data != null ? data.toString() : '-',
            style: const TextStyle(fontSize: 35),
          ),
        ],
      ),
    );
  }
}
