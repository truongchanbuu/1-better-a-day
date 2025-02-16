import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';

class TodayQuote extends StatefulWidget {
  const TodayQuote({super.key});

  @override
  State<TodayQuote> createState() => _TodayQuoteState();
}

class _TodayQuoteState extends State<TodayQuote> {
  late String quote;

  List<String> get quotes => [
        S.current.habit_quote_1,
        S.current.habit_quote_2,
        S.current.habit_quote_3,
        S.current.habit_quote_4,
        S.current.habit_quote_5,
      ];

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  String _getRandomQuote() {
    return quotes[Random().nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    quote = _getRandomQuote();

    return AnimatedTextKit(
      key: ValueKey('today_page_quote_$locale'),
      totalRepeatCount: 1,
      displayFullTextOnTap: true,
      animatedTexts: [
        TyperAnimatedText(
          quote,
          textStyle: TextStyle(
            overflow: TextOverflow.visible,
            fontStyle: FontStyle.italic,
            fontSize: AppFontSize.h3,
          ),
        ),
      ],
    );
  }
}
