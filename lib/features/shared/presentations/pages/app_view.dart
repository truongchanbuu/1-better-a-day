import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import '../../../../core/constants/app_font_size.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/enums/tab_type.dart';
import '../../../../injection_container.dart';
import '../../../rewards/presentations/blocs/challenge_crud/challenge_crud_bloc.dart';
import '../../../settings/presentations/bloc/settings_cubit.dart';
import '../widgets/drawer_slider.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final GlobalKey<SliderDrawerState> _sliderKey;
  TabType _currentTab = TabType.today;

  @override
  void initState() {
    _sliderKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SliderDrawer(
          key: _sliderKey,
          appBar: SliderAppBar(
            isTitleCenter: false,
            appBarPadding: EdgeInsets.zero,
            appBarColor: Theme.of(context).appBarTheme.backgroundColor!,
            drawerIconColor: AppColors.lightText,
            trailing: _currentTab.trailing,
            title: Text(
              _currentTab.title,
              locale: context
                  .select((SettingsCubit settings) => settings.currentLocale),
              style: const TextStyle(
                color: AppColors.lightText,
                fontSize: AppFontSize.appBarTitle,
              ),
            ),
          ),
          slider: DrawerSlider(
            currentTab: _currentTab,
            onChanged: (tab) {
              setState(() => _currentTab = tab);
              _sliderKey.currentState?.closeSlider();
            },
          ),
          child: IndexedStack(
            index: _currentTab.index,
            children: TabType.values.map((tab) => tab.page).toList(),
          ),
        ),
      ),
    );
  }
}
