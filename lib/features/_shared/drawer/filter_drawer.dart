import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: Colors.red,
          child: const Column(children: [Text('Hello')]),
        ),
      ),
    );
  }
}
