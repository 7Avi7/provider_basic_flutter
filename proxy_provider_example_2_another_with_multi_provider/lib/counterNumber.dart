import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proxy_provider_example_2_another_with_multi_provider/translation.dart';

class CounterNumber extends StatelessWidget {
  const CounterNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = Provider.of<Translation>(context);

    return Text(
      translation.title,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
