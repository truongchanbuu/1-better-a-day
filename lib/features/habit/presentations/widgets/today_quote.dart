import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../generated/l10n.dart';

class TodayQuote extends StatefulWidget {
  const TodayQuote({super.key});

  @override
  State<TodayQuote> createState() => _TodayQuoteState();
}

class _TodayQuoteState extends State<TodayQuote> {
  bool isFinished = false;
  late int randomQuoteNumber;

  static final List<String> quotes = [
    S.current.habit_quote_1,
    S.current.habit_quote_2,
    S.current.habit_quote_3,
    S.current.habit_quote_4,
    S.current.habit_quote_5,
  ];

  @override
  void initState() {
    super.initState();
    randomQuoteNumber = Random().nextInt(quotes.length);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      totalRepeatCount: 1,
      animatedTexts: [
        TyperAnimatedText(
          quotes[randomQuoteNumber],
          textStyle: const TextStyle(
            overflow: TextOverflow.visible,
            fontStyle: FontStyle.italic,
            fontSize: AppFontSize.h3,
          ),
        )
      ],
    );
  }
}
