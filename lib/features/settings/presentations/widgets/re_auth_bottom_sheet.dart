import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/helpers/alert_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/login/login_cubit.dart';
import '../../../user/presentations/pages/email_re_auth_page.dart';

class ReAuthBottomSheet extends StatelessWidget {
  const ReAuthBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          AlertHelper.showAwesomeSnackBar(
            context,
            S.current.failure_title,
            state.errorMessage ?? S.current.unknown_exception,
            ContentType.failure,
          );

          Navigator.pop(context, false);
        } else if (state is LoginSucceed) {
          AlertHelper.showAwesomeSnackBar(
            context,
            S.current.success_title,
            S.current.login_success_title,
            ContentType.success,
          );

          Navigator.pop(context, true);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.google, color: Colors.blue),
              title: Text(S.current.re_auth_with_google),
              onTap: context.read<LoginCubit>().reAuthWithGoogle,
            ),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.red),
              title: Text(S.current.re_auth_with_email),
              onTap: () async {
                final navigator = Navigator.of(context);
                bool? isAuth = await Navigator.push(
                  context,
                  PageTransition(
                    child: BlocProvider(
                      create: (context) => getIt.get<LoginCubit>(),
                      child: const EmailReAuthPage(),
                    ),
                    type: PageTransitionType.leftToRight,
                  ),
                );

                navigator.pop(isAuth ?? false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
