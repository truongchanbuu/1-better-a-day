import 'package:flutter/material.dart';

class ReviewActionPage extends StatefulWidget {
  const ReviewActionPage({super.key});

  @override
  State<ReviewActionPage> createState() => _ReviewActionPageState();
}

class _ReviewActionPageState extends State<ReviewActionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
