import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorExample extends StatelessWidget {
  const SelectorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => CounterNotifier(),
        child: const MyHomePage(
          title: 'Selector Example',
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    print('Home Page Building');

    final count = context.select((CounterNotifier notifier) {
      return notifier.count;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

            RedBox(
              isRed: true,
              child: Selector<CounterNotifier, int>(
                selector: (_, counterNotifier) => counterNotifier.count,
                builder: (context, value, child) {
                  return CounterNumber(
                    number: count,
                  );
                },
              ),
            ),

            // Selector<CounterNotifier, int>(
            //   selector: (_, counterNotifier) => counterNotifier.count,
            //   builder: (context, value, child) {
            //     return RedBox(
            //         isRed: true,
            //         child: CounterNumber(
            //           number: value,
            //         ));
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            Provider.of<CounterNotifier>(context, listen: false).increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterNotifier with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class RedBox extends StatelessWidget {
  const RedBox({
    super.key,
    required this.child,
    required this.isRed,
  });
  final Widget child;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    print('Red Box Building');
    return Container(
      // color: Colors.red,
      color: isRed ?? true ? Colors.redAccent : Colors.blue,
      width: 50,
      height: 50,
      child: Center(
        child: child,
      ),
    );
  }
}

class CounterNumber extends StatelessWidget {
  const CounterNumber({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    print('CounterNumber Building');
    return Text(
      number.toString(),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
