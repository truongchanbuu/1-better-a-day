import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../../../../core/constants/app_color.dart';

// TODO: BAO CAO 30 PAGES
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SliderDrawer(
          appBar: const SliderAppBar(
            isTitleCenter: false,
            appBarPadding: EdgeInsets.zero,
            appBarColor: AppColors.primary,
            drawerIconColor: AppColors.lightText,
          ),
          slider: Container(color: Colors.red),
          child: Container(color: Colors.yellow),
        ),
      ),
    );
  }
}
