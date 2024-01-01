import 'package:flutter/material.dart';

import 'consumer_example.dart';

void main() {
  runApp(const ConsumerExample());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  // final String title;
  @override
  Widget build(BuildContext context) {
    return const ConsumerExample();
  }
}
