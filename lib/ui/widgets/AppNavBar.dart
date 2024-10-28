import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';

class AppNavBar extends StatefulWidget {
  final Color rippleColor;
  final Color hoverColor;
  final bool haptic;
  final double tabBorderRadius;
  final Curve curve;
  final Duration duration;
  final double gap;
  final Color color;
  final Color activeColor;
  final double iconSize;
  final Color tabBackgroundColor;
  final EdgeInsets padding;
  final double height;
  final EdgeInsets margin;
  final List<GButton> tabs;

  const AppNavBar.mainTheme({
    super.key,
    this.rippleColor = Colors.black,
    this.hoverColor = Colors.white,
    this.haptic = true,
    this.tabBorderRadius = 17,
    this.curve = Curves.easeOutExpo,
    this.duration = const Duration(milliseconds: 300),
    this.gap = 8,
    this.color = Colors.grey,
    this.activeColor = Colors.white,
    this.iconSize = 24,
    this.tabBackgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.height = 80,
    this.margin = const EdgeInsets.fromLTRB(16, 10, 10, 16),
    this.tabs = const [
      GButton(
        icon: Icons.home,
        text: 'Home',
      ),
      GButton(
        icon: Icons.search,
        text: 'Search',
      ),
      GButton(
        icon: Icons.verified_user,
        text: 'Profile',
      ),
    ],
  });

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Padding(
        padding: widget.margin,
        child: GNav(
          rippleColor: widget.rippleColor,
          hoverColor: widget.hoverColor,
          haptic: widget.haptic,
          tabBorderRadius: widget.tabBorderRadius,
          curve: widget.curve,
          duration: widget.duration,
          gap: widget.gap,
          color: widget.color,
          activeColor: widget.activeColor,
          iconSize: widget.iconSize,
          tabBackgroundColor: widget.tabBackgroundColor.withOpacity(0.1),
          padding: widget.padding,
          tabs: widget.tabs,
        ),
      ),
    );
  }
}
