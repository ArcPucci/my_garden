import 'package:flutter/material.dart';
import 'package:my_garden/widgets/widgets.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({
    super.key,
    required this.child,
    this.hasBottomBar = false,
    required this.path,
  });

  final String path;
  final bool hasBottomBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: child),
            if (hasBottomBar) CustomBottomBar(path: path),
          ],
        ),
      ),
    );
  }
}
