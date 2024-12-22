import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/helpers/alert_helper.dart';
import '../../../../generated/l10n.dart';
import '../bloc/update_info_cubit.dart';

class UpdateDisplayNamePage extends StatefulWidget {
  const UpdateDisplayNamePage({super.key});

  @override
  State<UpdateDisplayNamePage> createState() => _UpdateDisplayNamePageState();
}

class _UpdateDisplayNamePageState extends State<UpdateDisplayNamePage> {
  bool _isValid = false;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return S.current.empty_field;
                      }

                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          _isValid = false;
                        } else {
                          _isValid = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: S.current.display_name,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.name,
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

  void _onSubmit() {
    context.read<UpdateInfoCubit>().updateDisplayName(_controller.text);
  }
}
