import 'dart:async';

import 'package:flutter/material.dart';

class Balloon {
  Offset position;
  double size;
  int score;
  double movementSpeed;
  String imageAsset;

  Balloon({
    required this.position,
    required this.size,
    required this.score,
    required this.movementSpeed,
    required this.imageAsset,
  });
}

class BalloonAnimation extends StatefulWidget {
  @override
  _BalloonAnimationState createState() => _BalloonAnimationState();
}

class _BalloonAnimationState extends State<BalloonAnimation>
    with SingleTickerProviderStateMixin {
  List<Balloon> balloons = [
    Balloon(
        position: Offset(0, 1),
        size: 100,
        score: 2,
        movementSpeed: 10,
        imageAsset: "Assets/images/balloon.png")
  ]; // List to store generated balloons
  late AnimationController _animationController;
  int score = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Generate balloons every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      generateBalloon();
    });

    // Start the balloon animation
    _animationController.repeat();
  }

  void generateBalloon() {
    // Generate a new balloon and add it to the list of balloons
    setState(() {
      final balloon = Balloon(
          position: Offset(
            20 + (MediaQuery.of(context).size.width - 40) * 0.8 * 0.2,
            MediaQuery.of(context).size.height,
          ),
          size: 40,
          score: 2,
          movementSpeed: 2,
          imageAsset: "Assets/images/balloon.png");
      balloons.add(balloon);
    });
  }

  void popBalloon(int index) {
    // Remove the popped balloon from the list and update the score
    setState(() {
      balloons.removeAt(index);
      score += 2;
    });
  }

  void missBalloon() {
    // Subtract points for a missed balloon
    setState(() {
      score -= 1;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          // Wrap the Iterable of Positioned widgets in a Stack
          children: balloons.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final balloon = entry.value;
              return Positioned(
                left: balloon.position.dx,
                top: balloon.position.dy,
                child: GestureDetector(
                  onTap: () {
                    popBalloon(index);
                  },
                  child: Image.asset(
                    balloon.imageAsset,
                    width: balloon.size,
                    height: balloon.size,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
