import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/words.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.cur_words,
  });

  final Words? cur_words;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(colors: [
          Color(0xFF804DFB),
          Color(0xFFA981F9),
          Color(0xFF8452F1),
        ]).createShader(Offset.zero & bounds.size);
      },
      child: Text(
        cur_words!.words_original,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}