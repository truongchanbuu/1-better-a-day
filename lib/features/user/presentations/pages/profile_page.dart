import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/gender.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../core/helpers/alert_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import '../../../auth/presentations/bloc/login/login_cubit.dart';
import '../../../settings/presentations/bloc/settings_cubit.dart';
import '../../../settings/presentations/widgets/re_auth_bottom_sheet.dart';
import '../../../settings/presentations/widgets/setting_selection_bottom_sheet.dart';
import '../bloc/update_info_cubit.dart';
import '../widgets/account_setting_item.dart';
import '../widgets/account_setting_section.dart';
import '../widgets/user_avatar.dart';
import 'update_display_name_page.dart';
import 'update_email_page.dart';
import 'update_password_page.dart';
import 'update_phone_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const TextStyle _valueTextStyle = TextStyle(
    fontSize: AppFontSize.bodyMedium,
    color: Colors.grey,
  );
  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<UpdateInfoCubit, UpdateInfoState>(
          listener: (context, state) {
            if (state is UpdateFailed) {
              AlertHelper.showAwesomeSnackBar(
                context,
                S.current.failure_title,
                '${S.current.update_failure_title}: ${state.message}',
                ContentType.failure,
              );
            } else if (state is UpdateSucceed) {
              AlertHelper.showAwesomeSnackBar(
                context,
                S.current.success_title,
                S.current.update_success_title,
                ContentType.success,
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.marginL),
                  child: Center(
                    child: UserAvatar(user: currentUser),
                  ),
                ),

                // Personal Info
                AccountSettingSection(
                  title: S.current.personal_info_section,
                  items: [
                    AccountSettingItem(
                      onTap: () => _onUpdateDisplayName(context),
                      leading: const Icon(Icons.person, color: Colors.green),
                      title: S.current.display_name,
                      value: Text(
                        currentUser.username ?? '',
                        style: _valueTextStyle,
                      ),
                    ),
                    AccountSettingItem(
                      onTap: () => _onUpdateGender(context, currentUser.gender),
                      leading: const Icon(
                        FontAwesomeIcons.person,
                        color: Colors.redAccent,
                      ),
                      title: S.current.gender_field,
                      value: Text(
                        currentUser.gender?.toUpperCaseFirstLetter ?? '',
                        style: _valueTextStyle,
                      ),
                    ),
                    AccountSettingItem(
                      onTap: null,
                      leading: const Icon(
                        FontAwesomeIcons.calendar,
                        color: Colors.orange,
                      ),
                      title: S.current.age_field,
                      value: Text(
                        currentUser.dateOfBirth != null
                            ? DateTimeHelper.calculateAge(
                                    currentUser.dateOfBirth!)
                                .toString()
                            : '',
                        style: _valueTextStyle,
                      ),
                    ),
                    AccountSettingItem(
                      onTap: () =>
                          _onUpdateBirthDate(context, currentUser.dateOfBirth),
                      leading: const Icon(
                        FontAwesomeIcons.cakeCandles,
                        color: Colors.pink,
                      ),
                      title: S.current.birth_date,
                      value: Text(
                        currentUser.dateOfBirth != null
                            ? _formatBirthDate(
                                context, currentUser.dateOfBirth!)
                            : '',
                        style: _valueTextStyle,
                      ),
                    ),
                  ],
                ),

                // Account Info
                AccountSettingSection(
                  title: S.current.account_section,
                  items: [
                    AccountSettingItem(
                      onTap: () => _onUpdateEmail(context),
                      title: 'Email',
                      leading: const Icon(
                        Icons.email,
                        color: AppColors.primary,
                      ),
                      value: Text(
                        currentUser.email?.obscure ?? '',
                        style: _valueTextStyle,
                      ),
                    ),
                    if (currentUser.provider == 'password')
                      AccountSettingItem(
                        onTap: () => _onUpdatePassword(context),
                        leading:
                            const Icon(Icons.password, color: Colors.orange),
                        title: S.current.reset_password,
                        value: const Text('***', style: _valueTextStyle),
                      ),
                    AccountSettingItem(
                      onTap: () => _onPhoneNumberUpdate(context),
                      leading: const Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.green,
                      ),
                      title: S.current.phone_number,
                      value: Text(
                        (currentUser.phoneNumber?.length ?? 0) > 3
                            ? '***${currentUser.phoneNumber?.lastNLetter(3)}'
                            : '',
                        style: _valueTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatBirthDate(BuildContext context, DateTime birthDate) {
    return DateTimeHelper.formatFullDate(
      birthDate,
      locale: context.select(
          (SettingsCubit settings) => settings.currentLocale.languageCode),
    );
  }

  Future<bool?> _showReAuthForm(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => getIt.get<LoginCubit>(),
        child: const ReAuthBottomSheet(),
      ),
    );
  }

  void _onUpdateDisplayName(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<UpdateInfoCubit>(),
          child: const UpdateDisplayNamePage(),
        ),
        duration: AppCommons.pageTransitionDuration,
        reverseDuration: AppCommons.pageTransitionDuration,
        type: PageTransitionType.bottomToTop,
      ),
    );
  }

  void _onUpdateGender(BuildContext ctx, String? userGender) {
    showModalBottomSheet(
      useSafeArea: true,
      context: ctx,
      builder: (context) => SettingSelectionBottomSheet<String>(
        choices: Gender.values
            .map((gender) => gender.name.toUpperCaseFirstLetter)
            .toList(),
        selected: userGender?.toUpperCaseFirstLetter,
        onSelected: (choice) {
          ctx.read<UpdateInfoCubit>().updateGender(choice.toLowerCase());
        },
      ),
    );
  }

  static const _100YearInDays = 365 * 100;
  void _onUpdateBirthDate(BuildContext ctx, DateTime? birthDate) {
    showDialog(
      context: ctx,
      builder: (context) => SfDateRangePicker(
        showNavigationArrow: true,
        initialDisplayDate: DateTime.now(),
        maxDate: DateTime.now(),
        minDate: DateTime.now().subtract(const Duration(days: _100YearInDays)),
        showTodayButton: true,
        showActionButtons: true,
        cancelText: S.current.cancel_button.toUpperCase(),
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.single,
        selectionColor: AppColors.primary,
        selectionTextStyle: const TextStyle(
          color: AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
        onCancel: () => Navigator.pop(context),
        onSubmit: (selectedDate) {
          if (selectedDate != null && selectedDate is DateTime) {
            ctx.read<UpdateInfoCubit>().updateBirthDate(selectedDate);
          } else {
            SmartDialog.showToast(S.current.no_date_selected);
          }

          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _onUpdateEmail(BuildContext context) async {
    final navigator = Navigator.of(context);
    final isAuthenticated = await _showReAuthForm(context);

    if (isAuthenticated ?? false) {
      navigator.push(PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<UpdateInfoCubit>(),
          child: const UpdateEmailPage(),
        ),
        type: PageTransitionType.leftToRight,
      ));
    }
  }

  Future<void> _onUpdatePassword(BuildContext context) async {
    final navigator = Navigator.of(context);
    final isAuthenticated = await _showReAuthForm(context);

    if (isAuthenticated ?? false) {
      navigator.push(PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<UpdateInfoCubit>(),
          child: const UpdatePasswordPage(),
        ),
        type: PageTransitionType.leftToRight,
      ));
    }
  }

  Future<void> _onPhoneNumberUpdate(BuildContext context) async {
    final navigator = Navigator.of(context);
    final isAuthenticated = await _showReAuthForm(context);

    if (isAuthenticated ?? false) {
      navigator.push(PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<UpdateInfoCubit>(),
          child: const UpdatePhonePage(),
        ),
        type: PageTransitionType.leftToRight,
      ));
    }
  }
}
