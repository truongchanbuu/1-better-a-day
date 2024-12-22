import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../generated/l10n.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/signup/signup_cubit.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static const double _safeBottomSpacing = 40;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterLogin(
        theme: LoginTheme(
          cardTopPosition: MediaQuery.of(context).size.height / 4,
          primaryColor: AppColors.primary,
          accentColor: AppColors.secondary,
          afterHeroFontSize: AppFontSize.h1,
          beforeHeroFontSize: AppFontSize.h1,
          titleStyle: const TextStyle(
            color: AppColors.lightText,
            fontWeight: FontWeight.bold,
          ),
          footerBottomPadding: _safeBottomSpacing,
          footerTextStyle: const TextStyle(
            color: AppColors.lightText,
            fontSize: AppFontSize.labelLarge,
            overflow: TextOverflow.visible,
          ),
        ),
        onLogin: _onLogIn,
        onSignup: _onSignUp,
        onRecoverPassword: _onRecoveryPassword,
        title: AppCommons.appName,
        titleTag: AppCommons.shortAppName,
        onConfirmSignup: null,
        footer: S.current.term_and_condition_statement,
        passwordValidator: (value) =>
            (value?.length ?? 0) < 6 ? S.current.invalid_password : null,
        hideProvidersTitle: true,
        loginAfterSignUp: true,
        validateUserImmediately: true,
        loginProviders: [
          LoginProvider(
            icon: FontAwesomeIcons.google,
            callback: () async {
              return await context.read<LoginCubit>().logInWithGoogle();
            },
          ),
        ],
        messages: LoginMessages(
          recoverPasswordDescription: S.current.recovery_description,
        ),
        onSubmitAnimationCompleted: () =>
            Navigator.popUntil(context, ModalRoute.withName('/')),
      ),
    );
  }

  Future<String?> _onLogIn(LoginData loginData) async {
    context.read<LoginCubit>().emailChanged(loginData.name);
    context.read<LoginCubit>().passwordChanged(loginData.password);

    return await context.read<LoginCubit>().logInWithCredentials();
  }

  Future<String?> _onSignUp(SignupData signUpData) async {
    context.read<SignUpCubit>().emailChanged(signUpData.name!);
    context.read<SignUpCubit>().passwordChanged(signUpData.password!);

    return await context.read<SignUpCubit>().signUpFormSubmitted();
  }

  Future<String?> _onRecoveryPassword(String email) async {
    return await context.read<LoginCubit>().resetPassword(email);
  }
}
