import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerExample extends StatelessWidget {
  const ConsumerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageAddNotifier(),
          child: ConsumerAddCardText(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, child) {
            final provider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              theme: provider.theme,
              debugShowCheckedModeBanner: false,
              home: ConsumerAddCardText(),
            );
          },
        )
      ],
    );
  }
}

class ConsumerAddCardText extends StatelessWidget {
  ConsumerAddCardText({super.key});
  final TextEditingController controllerForText = TextEditingController();
  // final provider = Provider.of<ThemeProvider>(context);

  // bool switchValue = provider.isDarkMode();
  // get switchValue => true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    bool switchValue = provider.isDarkMode();
    print('------------------------------');

    print('Building BuildContext context');
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        title: const Text(
          'Languages',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.yellow,
        actions: [
          Switch(
            activeColor: Colors.green,
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.red,
            value: switchValue,
            onChanged: (value) {
              // switchValue = value;

              provider.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controllerForText,
              //     Provider.of<LanguageAddNotifier>(context, listen: false)
              //         .textField,
              decoration: InputDecoration(
                hintText: 'Please Enter Language name here',
                hintStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.book_online_rounded),
                prefixIconColor: Colors.blueAccent,
                filled: true,
                fillColor: Colors.white10,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 4.5,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2.0,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
              width: size.width * 0.30,
            ),
            SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.30,
              child: ElevatedButton.icon(
                onPressed: () {
                  // final userInput = controllerForText.text;

                  // languages.add(userInput);

                  // controllerForText.clear();

                  Provider.of<LanguageAddNotifier>(context, listen: false)
                      .addedList(controllerForText.text);

                  // Provider.of<LanguageAddNotifier>(context, listen: false)
                  //     .addedList(controllerForText.text);
                  // Provider.of<LanguageAddNotifier>(context, listen: false)
                  //     .addedList(controllerForText);
                },
                icon: Builder(builder: (context) {
                  print('Add new Language ElevatedButton Pressed');
                  return const Icon(Icons.add_circle);
                }),
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  backgroundColor: Colors.black45,
                  foregroundColor: Colors.amber,
                  side: const BorderSide(width: 3, color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                label: const Text(
                  "Add new Language",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
              width: size.width * 0.30,
            ),
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Expanded(
                child: Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Container(
                      width: 330.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Consumer<LanguageAddNotifier>(
                        builder: (_, value, __) {
                          if (value.languages.isNotEmpty) {
                            print('From ListView 1 (if Statement)');
                            return ListView.builder(
                              itemCount: value.languages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Card(
                                    color: Colors.green,
                                    child: ListTile(
                                      title: Text(value.languages[index]),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            print('From ListView 2 (else Statement)');
                            return const Center(
                              child: Text(
                                'Empty List',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
              width: size.width * 0.30,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Clear All Cards Button Pressed');
                  Provider.of<LanguageAddNotifier>(context, listen: false)
                      .clearList();
                  // languages.clear();
                  // controllerForStream.sink.add(languages);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Clear All Cards",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
              width: size.width * 0.30,
            ),
            Flexible(
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print('Exit Executed');
                    // Call the reset function when the button is pressed
                    resetApp();
                  },
                  child: const Text('Exit App'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetApp() {
    exit(0);
  }
}

class LanguageAddNotifier with ChangeNotifier {
  List<String> languages = [];
  // TextEditingController controllerForText = TextEditingController();

  void addedList(String textForAddList) {
    languages.add(textForAddList);
    notifyListeners();
  }

  void clearList() {
    languages.clear();
    notifyListeners();
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.light();

  ThemeData get theme => _theme;

  void toggleTheme() {
    final isDark = _theme == ThemeData.dark();

    if (isDark) {
      _theme = ThemeData.light();
    } else {
      _theme = ThemeData.dark();
    }

    notifyListeners();
  }

  bool isDarkMode() {
    return _theme == ThemeData.dark();
  }
}
