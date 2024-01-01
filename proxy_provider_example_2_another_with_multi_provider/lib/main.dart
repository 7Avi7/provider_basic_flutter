import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proxy_provider_example_2_another_with_multi_provider/translation.dart';

import 'FirstPartSentence.dart';
import 'SecondPartSentence.dart';
import 'counterNumber.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          Provider<FirstPartSentence>(
            create: (context) =>
                const FirstPartSentence(' You Clicked the button '),
          ),
          Provider<SecondPartSentence>(
            create: (context) => const SecondPartSentence(' times '),
          ),
        ],
        child: const MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProxyProvider0<Translation>(
              update: (context, _) {
                final firstPart = Provider.of<FirstPartSentence>(context).text;
                final secondPart =
                    Provider.of<SecondPartSentence>(context).text;
                return Translation(
                  firstPart + _counter.toString() + secondPart,
                );
              },
              child: const CounterNumber(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
