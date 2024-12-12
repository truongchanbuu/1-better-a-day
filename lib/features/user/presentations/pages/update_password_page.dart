import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/helpers/snack_bar_helper.dart';
import '../../../../generated/l10n.dart';
import '../bloc/update_info_cubit.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  bool _isValidForm = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.marginM),
                          _buildNewPasswordField(),
                          const SizedBox(height: AppSpacing.marginM),
                          _buildConfirmPasswordField(),
                        ],
                      ),
                    ),
                  ),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildNewPasswordField() => TextFormField(
        controller: _newPasswordController,
        obscureText: _obscureNewPassword,
        validator: _validateNewPassword,
        onChanged: (_) => _validateFormOnChange(),
        decoration: InputDecoration(
          labelText: S.current.password_field,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureNewPassword = !_obscureNewPassword;
              });
            },
          ),
        ),
      );

  TextFormField _buildConfirmPasswordField() => TextFormField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword,
        validator: _validateConfirmPassword,
        onChanged: (_) => _validateFormOnChange(),
        decoration: InputDecoration(
          labelText: S.current.confirm_password_field,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
        ),
      );

  ElevatedButton _buildSubmitButton() => ElevatedButton(
        onPressed: _isValidForm ? _onSubmit : null,
        child: Text(
          S.current.send_button,
          style: const TextStyle(color: AppColors.lightText),
        ),
      );

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) return S.current.empty_field;
    if (value.length < 6) {
      return S.current.invalid_password;
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return S.current.empty_field;
    if (value != _newPasswordController.text) {
      return S.current.passwords_do_not_match;
    }
    return null;
  }

  void _validateFormOnChange() {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isValidForm = isValid;
    });
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<UpdateInfoCubit>()
          .updatePassword(_newPasswordController.text);
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
        S.current.update_success_title,
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
