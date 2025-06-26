import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('logo'));
  }
}

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, this.e});
  final String? e;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          const Icon(CupertinoIcons.exclamationmark_triangle_fill, size: 70),
          const Text('logo'),
          Text(widget.e == null ? '' : widget.e.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: CupertinoColors.destructiveRed))
        ]));
  }
}
