import 'package:ballontap/Screens/mainframe.dart';
import 'package:flutter/material.dart';

class Endscreen extends StatelessWidget {
  const Endscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                "Home",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Lexend",
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Mainframe(),
                ));
              },
              child: const Text(
                "Restart",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Lexend",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
