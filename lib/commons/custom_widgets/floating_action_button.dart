import 'package:flutter/material.dart';

class ApbaFloatingActionButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  const ApbaFloatingActionButton(
      {super.key,
      required this.onPressed,
      required this.tooltip,
      required this.icon});

  @override
  // ignore: library_private_types_in_public_api
  _ApbaFloatingActionButtonState createState() =>
      _ApbaFloatingActionButtonState();
}

class _ApbaFloatingActionButtonState extends State<ApbaFloatingActionButton>
    with SingleTickerProviderStateMixin {
  Widget toggle() {
    return FloatingActionButton(
        onPressed: widget.onPressed, child: Icon(widget.icon));
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
