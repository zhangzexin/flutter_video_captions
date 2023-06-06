import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/words.dart';

import 'gradient_text.dart';

class WordsWidgets extends StatelessWidget {
  const WordsWidgets({
    super.key,
    required this.showTextSrt,
    required this.cur_words,
  }) ;

  final TextSpan? showTextSrt;
  final Words? cur_words;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showTextSrt != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.30,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text.rich(
                  showTextSrt!,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        if (cur_words != null)
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 45),
                ),
                GradientText(cur_words: cur_words),
                Text(
                  cur_words!.pronunciation,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    cur_words!.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF3c3c3c),
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}


