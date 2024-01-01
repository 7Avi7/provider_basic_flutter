import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_change_by_change_notifier_provider/test.dart';
import 'package:theme_change_by_change_notifier_provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeProvider can't be accessed here using the above context as this youTube channel

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          theme: provider.theme,
          debugShowCheckedModeBanner: false,
          home: const TestPage(),
        );
      },
    );
  }
}
