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
  _ApbaFloatingActionButtonState createState() =>
      _ApbaFloatingActionButtonState();
}

class _ApbaFloatingActionButtonState extends State<ApbaFloatingActionButton>
    with SingleTickerProviderStateMixin {
  // bool isOpened = false;
  // late AnimationController _animationController;
  // late Animation<Color?> _animateColor;
  // late Animation<double> _animateIcon;
  // Curve _curve = Curves.easeOut;

  // @override
  // initState() {
  //   _animationController =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 500))
  //         ..addListener(() {
  //           setState(() {});
  //         });
  //   _animateIcon =
  //       Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  //   _animateColor = ColorTween(
  //     begin: Colors.blue,
  //     end: Colors.red,
  //   ).animate(CurvedAnimation(
  //     parent: _animationController,
  //     curve: Interval(
  //       0.00,
  //       1.00,
  //       curve: _curve,
  //     ),
  //   ));
  //   super.initState();
  // }

  // @override
  // dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  // animate() {
  //   if (!isOpened) {
  //     _animationController.forward();
  //   } else {
  //     _animationController.reverse();
  //   }
  //   isOpened = !isOpened;
  // }

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
