import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_change_by_change_notifier_provider/theme_provider.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    bool switchValue = provider.isDarkMode();

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 40,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Theme Change by Switch and Button',
          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          child: Stack(
            children: [
              Positioned(
                top: 200,
                left: 100,
                child: SizedBox(
                  height: 70,
                  // width: ,
                  child: OutlinedButton(
                    onPressed: () {
                      provider.toggleTheme();
                    },
                    style: OutlinedButton.styleFrom(
                      shadowColor: Colors.red,
                      side: const BorderSide(
                        color: Colors.yellow,
                        width: 1,
                      ),
                      elevation: 4,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,

                      // minimumSize: const Size(double.infinity, 10),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Click To Change The Theme',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1,
                left: 170,
                child: Switch(
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.red,
                  value: switchValue,
                  onChanged: (value) {
                    // switchValue = value;

                    provider.toggleTheme();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
