import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  static const String name = 'Search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Search')));
  }
}
