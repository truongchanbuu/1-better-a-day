import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/helpers/snack_bar_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentations/bloc/login/login_cubit.dart';

class EmailReAuthPage extends StatefulWidget {
  const EmailReAuthPage({super.key});

  @override
  State<EmailReAuthPage> createState() => _EmailReAuthPageState();
}

class _EmailReAuthPageState extends State<EmailReAuthPage> {
  late final TextEditingController passwordController;
  late final FocusNode _focusNode;

  bool _isObscure = true;

  @override
  void initState() {
    passwordController = TextEditingController();
    _focusNode = FocusNode()..requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _unShowKeyboard();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailed) {
                SmartDialog.dismiss();
                AlertHelper.showAwesomeSnackBar(
                  context,
                  S.current.update_failure_title,
                  '${state.errorMessage}. ${S.current.try_again}',
                  ContentType.failure,
                );
              } else if (state is LoginSucceed) {
                SmartDialog.dismiss();
                AlertHelper.showAwesomeSnackBar(
                  context,
                  S.current.success_title,
                  S.current.login_success_title,
                  ContentType.success,
                );

                Navigator.pop(context, true);
              } else if (state is LoginInProgressing) {
                SmartDialog.showLoading(msg: S.current.loading_title);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.marginL),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: passwordController,
                          focusNode: _focusNode,
                          obscureText: _isObscure,
                          onFieldSubmitted: _reAuth,
                          decoration: InputDecoration(
                            labelText: S.current.password_field,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _isObscure = !_isObscure),
                              icon: _isObscure
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          textInputAction: TextInputAction.send,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _reAuth(passwordController.text),
                    child: Text(
                      S.current.send_button,
                      style: const TextStyle(
                        color: AppColors.lightText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _reAuth(String text) {
    _unShowKeyboard();
    context.read<LoginCubit>().reAuthWithEmail(text);
  }

  void _unShowKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
