import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/helpers/snack_bar_helper.dart';
import '../../../../generated/l10n.dart';
import '../bloc/update_info_cubit.dart';

class UpdatePhonePage extends StatefulWidget {
  const UpdatePhonePage({super.key});

  @override
  State<UpdatePhonePage> createState() => _UpdatePhonePageState();
}

class _UpdatePhonePageState extends State<UpdatePhonePage> {
  bool _isValid = false;

  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..requestFocus();
  }

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
          listener: (context, state) {
            if (state is UpdateFailed) {
              AlertHelper.showAwesomeSnackBar(
                context,
                S.current.update_failure_title,
                '${state.message}. ${S.current.try_again}',
                ContentType.failure,
              );
            } else if (state is UpdateSucceed) {
              AlertHelper.showAwesomeSnackBar(
                context,
                S.current.success_title,
                S.current.update_success_title,
                ContentType.success,
              );

              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.marginL),
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    validator: _validatePhoneNumber,
                    onChanged: (value) {
                      setState(() {
                        if (_validatePhoneNumber(value) != null) {
                          _isValid = false;
                        } else {
                          _isValid = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: S.current.phone_number,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                ElevatedButton(
                  onPressed: _isValid ? _onSubmit : null,
                  child: Text(
                    S.current.send_button,
                    style: const TextStyle(
                      color: AppColors.lightText,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return S.current.empty_field;
    }

    RegExp phoneRegExp = RegExp(
        r'^\+?(\d{1,3})?[-.\s]?(\(?\d{1,4}\)?)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$');

    if (!phoneRegExp.hasMatch(value!)) {
      return S.current.invalid_phone;
    }

    return null;
  }

  void _onSubmit() {
    context.read<UpdateInfoCubit>().updatePhoneNumber(_controller.text);
  }
}
