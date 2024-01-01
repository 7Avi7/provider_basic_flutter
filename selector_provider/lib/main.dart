import 'package:flutter/material.dart';
import 'package:selector_provider/selector_example.dart';

void main() {
  runApp(const SelectorExample());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  // final String title;
  @override
  Widget build(BuildContext context) {
    return const SelectorExample();
  }
}
