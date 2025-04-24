import 'package:flutter/material.dart';

class NavigationRailWidget extends StatefulWidget {
  const NavigationRailWidget({super.key});

  @override
  State<NavigationRailWidget> createState() => _NavigationRailWidgetState();
}

class _NavigationRailWidgetState extends State<NavigationRailWidget> {
  int _selectedIndex = 0;
  bool _isExtended = false;

  void _toggleExtended() => setState(() => _isExtended = !_isExtended);
  void _onDestinationSelected(int idx) => setState(() => _selectedIndex = idx);

  static const double _railMinWidth = 72; // default collapsed
  static const double _railMaxWidth = 256; // default extended

  @override
  Widget build(BuildContext context) {
    final railWidth = _isExtended ? _railMaxWidth : _railMinWidth;

    return NavigationRail(
      extended: _isExtended,
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onDestinationSelected,
      // minWidth: _railMinWidth,
      groupAlignment: 0.0,
      elevation: 4,
      leading: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: railWidth),
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _toggleExtended,
          ),
        ),
      ),
      trailing: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: railWidth),
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              /* … */
            },
          ),
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
      ],
    );
  }
}
