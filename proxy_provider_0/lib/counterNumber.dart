import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterNumber extends StatelessWidget {
  const CounterNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<int>(context).toString();

    return Text(
      counter,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
