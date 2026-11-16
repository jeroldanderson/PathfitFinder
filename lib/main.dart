import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'PathFitFinder',
    debugShowCheckedModeBanner: false,
    theme: buildTheme(),
    home: const AuthScreen(),
  );
}
