import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/helpers/snack_bar_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/data/models/email.dart';
import '../bloc/update_info_cubit.dart';

class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({super.key});

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isValidEmail = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<UpdateInfoCubit, UpdateInfoState>(
          listener: _handleStateChanges,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.marginL),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(child: _buildEmailField()),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildEmailField() => TextFormField(
        controller: _controller,
        validator: _validateEmail,
        onChanged: _validateEmailOnChange,
        decoration: const InputDecoration(
          labelText: 'Email',
          hintText: 'abc@example.com',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        textInputAction: TextInputAction.send,
        keyboardType: TextInputType.emailAddress,
      );

  ElevatedButton _buildSubmitButton() => ElevatedButton(
        onPressed: _isValidEmail ? _onSubmit : null,
        child: Text(
          S.current.send_button,
          style: const TextStyle(color: AppColors.lightText),
        ),
      );

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return S.current.empty_field;
    if (!Email.emailRegExp.hasMatch(value)) return S.current.invalid_email;
    return null;
  }

  void _validateEmailOnChange(String value) {
    setState(() {
      _isValidEmail = value.isNotEmpty && Email.emailRegExp.hasMatch(value);
    });
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UpdateInfoCubit>().updateEmail(_controller.text);
    }
  }

  void _handleStateChanges(BuildContext context, UpdateInfoState state) {
    if (state is UpdateFailed) {
      _showAlert(
        context,
        S.current.update_failure_title,
        '${state.message}. ${S.current.try_again}',
        ContentType.failure,
      );
    } else if (state is UpdateSucceed) {
      _showAlert(
        context,
        S.current.success_title,
        S.current.verify_email_sent,
        ContentType.success,
      );

      Navigator.pop(context);
    }
  }

  void _showAlert(
    BuildContext context,
    String title,
    String message,
    ContentType type,
  ) {
    AlertHelper.showAwesomeSnackBar(context, title, message, type);
  }
}
