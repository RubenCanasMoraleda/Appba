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
        // backgroundColor: _animateColor.value,
        onPressed: widget.onPressed,
        // tooltip: 'Toggle',
        child: Icon(widget.icon)
        //  AnimatedIcon(
        //   color: Colors.white,
        //   icon: AnimatedIcons.menu_close,
        //   progress: _animateIcon,
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
