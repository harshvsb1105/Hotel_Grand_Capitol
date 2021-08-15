import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  final Color color;
  final Widget child;
  const DashboardCards({Key key, this.color, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 180,
      child: child,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );
  }
}
