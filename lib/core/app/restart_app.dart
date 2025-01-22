import 'package:flutter/material.dart';

class RestartApp extends StatefulWidget {
  const RestartApp({super.key, required this.child});

  final Widget child;

  static void restart(BuildContext context) {
    final _RestartAppState? state =
        context.findAncestorStateOfType<_RestartAppState>();
    state?.restart();
  }

  @override
  State<RestartApp> createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  Key _key = UniqueKey();

  void restart() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
