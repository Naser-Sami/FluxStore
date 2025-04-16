import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  static const String name = 'Search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p24),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchAnchor.bar(
                      isFullScreen: true,
                      barElevation: const WidgetStatePropertyAll(4),
                      barBackgroundColor: WidgetStatePropertyAll(
                        color.surfaceContainer,
                      ),
                      barShape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(TRadius.r16),
                        ),
                      ),
                      viewBackgroundColor: color.surface,
                      suggestionsBuilder: (context, searchController) {
                        return const [
                          ListTile(title: Text('Suggestion 1')),
                          ListTile(title: Text('Suggestion 2')),
                          ListTile(title: Text('Suggestion 3')),
                        ];
                      },
                    ),
                  ),
                  const SizedBox(width: TPadding.p16),
                  OnTapScaler(
                    onTap: () {},
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(TRadius.r16),
                      child: Container(
                        width: 55,
                        height: 55,
                        padding: const EdgeInsets.all(TPadding.p12),
                        decoration: BoxDecoration(
                          color: color.surfaceContainer,
                          borderRadius: BorderRadius.circular(TRadius.r16),
                          boxShadow: [
                            BoxShadow(
                              color: color.shadow.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const IconWidget(name: 'filter'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
