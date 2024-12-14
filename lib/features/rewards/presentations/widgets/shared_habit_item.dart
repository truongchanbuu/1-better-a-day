import 'package:animated_react_button/animated_react_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../pages/share_challenge_tab.dart';

class SharedHabitItem extends StatefulWidget {
  final ShareTab tab;
  const SharedHabitItem({super.key, required this.tab});

  @override
  State<SharedHabitItem> createState() => _SharedHabitItemState();
}

class _SharedHabitItemState extends State<SharedHabitItem> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      margin: const EdgeInsets.all(AppSpacing.marginXS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Iconify(Twemoji.person_in_lotus_position),
            title: const Text(
              'Mindful Meditation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h3,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meditate for 10 minutes daily for 30 days',
                  style: TextStyle(
                    color: AppColors.grayText,
                    fontSize: AppFontSize.h4,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: AppSpacing.marginXS),
                _buildFooter(),
              ],
            ),
            trailing: widget.tab == ShareTab.discover
                ? _buildFavouriteButton()
                : _buildShareItemAction(),
          ),
          const SizedBox(height: AppSpacing.marginXS),
          if (widget.tab == ShareTab.discover) _buildAttendanceButton(),
        ],
      ),
    );
  }

  static const _footerTextStyle = TextStyle(
    fontSize: AppFontSize.labelLarge,
    color: AppColors.grayText,
  );
  static const double iconSize = 15;
  Widget _buildFooter() {
    return Wrap(
      runSpacing: 5,
      spacing: 15,
      children: [
        if (widget.tab == ShareTab.discover)
          const Text(
            'By Sarah',
            style: _footerTextStyle,
          ),
        IconWithText(
          icon: FontAwesomeIcons.peopleGroup,
          text: S.current.participant(234),
          iconColor: _footerTextStyle.color,
          iconSize: iconSize,
          fontSize: _footerTextStyle.fontSize,
          fontColor: _footerTextStyle.color,
        ),
        IconWithText(
          icon: FontAwesomeIcons.medal,
          text: S.current.completion(90),
          iconSize: iconSize,
          iconColor: _footerTextStyle.color,
          fontSize: _footerTextStyle.fontSize,
          fontColor: _footerTextStyle.color,
        ),
      ],
    );
  }

  Widget _buildAttendanceButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Iconify(Mdi.user_check, color: AppColors.lightText),
          const SizedBox(width: AppSpacing.marginS),
          Text(
            S.current.attendance_button,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteButton() {
    return AnimatedReactButton(
      defaultColor: isLiked ? Colors.red : Colors.black12,
      reactColor: !isLiked ? Colors.red : Colors.black12,
      defaultIcon: Icons.favorite,
      onPressed: () => setState(() => isLiked = !isLiked),
    );
  }

  Widget _buildShareItemAction() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          child: const Icon(
            FontAwesomeIcons.penToSquare,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: AppSpacing.marginS),
        GestureDetector(
          child: const Icon(
            FontAwesomeIcons.trash,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
