//------------
import 'dart:async';
import 'dart:math';
import 'package:ballontap/Screens/endscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Mainframe extends StatefulWidget {
  const Mainframe({Key? key}) : super(key: key);

  @override
  _MainframeState createState() => _MainframeState();
}

class _MainframeState extends State<Mainframe> {
  final ScrollController _scrollController = ScrollController();
  late Timer timer;
  Duration duration = const Duration(seconds: 120);

  List<List<bool>> visibility =
      List.generate(100, (index) => List.generate(3, (index) => true));
  List<List<int>> heartIndices = List.generate(
      100, (index) => List.generate(1, (index) => Random().nextInt(3)));
  int popCount = 0;
  int missCount = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (duration.inSeconds == 0) {
          timer.cancel();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Endscreen()),
          );
          return;
        }
        duration -= const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _handleTap(int rowIndex, int columnIndex) {
    if (visibility[rowIndex][columnIndex]) {
      print("Balloon popped!");
      setState(() {
        popCount += 2;
        visibility[rowIndex][columnIndex] = false;
      });
    } else {
      print("Missed the balloon!");
      setState(() {
        missCount -= 1;
      });
    }
    setState(() {
      score = popCount + missCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

              ListView.builder(
                controller: _scrollController,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Row(
                    children: List.generate(
                      3,
                      (i) => Expanded(
                        child: visibility[index][i]
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _handleTap(index, i);
                                    // _toggleScrollState();
                                  });
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    setState(() {
                                      // _toggleScrollState();
                                    });
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  child: (i == heartIndices[index][0])
                                      ? Image.asset(
                                          "Assets/Images/balloon.png",
                                        )
                                      : null,
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  );
                },
              ),


          Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: "Time: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
                ),
                Column(
                  children: [
                    Text(
                      "Score : $score",
                      style: const TextStyle(
                          // color: Colors.grey,
                          color: Colors.black54,
                          fontSize: 18,
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Pop : $popCount",
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Miss : $missCount",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//
