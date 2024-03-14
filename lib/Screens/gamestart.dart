import 'package:ballontap/Screens/mainframe.dart';
import 'package:flutter/material.dart';

class Gamestart extends StatelessWidget {
  const Gamestart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Pop the Balloon",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Lexend",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Mainframe(),
                ));
              },
              child: const Text(
                "Start",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Lexend",
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
