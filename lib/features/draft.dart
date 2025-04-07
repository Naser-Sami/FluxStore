// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void main() {
//   runApp(const MyApp());
// }

// final GoRouter _router = GoRouter(
//   navigatorKey: navigatorKey,
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomeScreen(),
//       routes: [
//         // https://localhost:7016/api/auth/reset-password
//         GoRoute(
//           path: 'api/auth/reset-password',
//           builder: (context, state) {
//             final token = state.uri.queryParameters['token'];
//             print('Deep link received for token: $token');
//             return ForgotPasswordScreen(token: token ?? 'No token found');
//           },
//         ),
//       ],
//     ),
//   ],
// );

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late final AppLinks _appLinks;

//   @override
//   void initState() {
//     super.initState();
//     _appLinks = AppLinks();
//     _setupDeepLinkHandler();
//   }

//   void _setupDeepLinkHandler() async {
//     // Handle incoming deep links
//     _appLinks.uriLinkStream.listen((Uri? uri) {
//       if (uri != null) {
//         print('Deep link received: $uri');
//         _handleDeepLink(uri);
//       }
//     });

//     // Handle initial deep link
//     final Uri? initialLink = await _appLinks.getInitialLink();
//     if (initialLink != null) {
//       print('Initial deep link: $initialLink');
//       _handleDeepLink(initialLink);
//     }
//   }

//   void _handleDeepLink(Uri uri) {
//     if (uri.pathSegments.contains('reset-password')) {
//       final token = uri.queryParameters['token'];
//       if (token != null && token.isNotEmpty) {
//         _router.go('/api/auth/reset-password?token=$token');
//       }
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(routerConfig: _router);
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             context.go(
//               '/api/auth/reset-password?token=so9hLWe124b+qH5V9ReTG4XisqokzN2Zmbws01FyPtpe0Vq0pR8ceITIFjI9IbraeA66jmKl97DT4bUxJuqcKg==',
//             );
//           },
//           child: const Text('Go to Reset Password'),
//         ),
//       ),
//     );
//   }
// }

// class ForgotPasswordScreen extends StatelessWidget {
//   final String token;

//   const ForgotPasswordScreen({super.key, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Token')),
//       body: Center(child: Text('Token: $token')),
//     );
//   }
// }

// // adb shell am start -a android.intent.action.VIEW \
// //   -c android.intent.category.BROWSABLE \
// //   -d "https://192.168.1.103:7016/api/auth/reset-password?token=so9hLWe124b+qH5V9ReTG4XisqokzN2Zmbws01FyPtpe0Vq0pR8ceITIFjI9IbraeA66jmKl97DT4bUxJuqcKg==" \
// //  "com.example.flux_store"

// // https://10.0.2.16:7016/api/auth/reset-password?token=so9hLWe124b+qH5V9ReTG4XisqokzN2Zmbws01FyPtpe0Vq0pR8ceITIFjI9IbraeA66jmKl97DT4bUxJuqcKg==
