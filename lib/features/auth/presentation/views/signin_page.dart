import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:date_split_app/core/common/views/home_page.dart';
import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/core_utils.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/features/auth/presentation/views/auth_page.dart';
import 'package:date_split_app/features/auth/presentation/widgets/auth_background.dart';
import 'package:date_split_app/core/common/widgets/confirm_action_button.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key, this.isAuthPage = true});

  final bool isAuthPage;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(Assets.kAuthHouseImage),
              CustomField(
                controller: emailController,
                hintText: 'Email',
                filled: true,
                fillColour: Styles.kStandardLightGrey,
                suffixIcon: const Icon(
                  Icons.email_outlined,
                ),
              ),
              const SizedBox(height: 20.0),
              CustomField(
                controller: passwordController,
                hintText: 'Password',
                filled: true,
                fillColour: Styles.kStandardLightGrey,
                obscureText: obscureText,
                onFieldSubmitted: (_) => signIn(context),
                suffixIcon: obscureText
                    ? IconButton(
                        onPressed: () =>
                            setState(() => obscureText = !obscureText),
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                      )
                    : IconButton(
                        onPressed: () =>
                            setState(() => obscureText = !obscureText),
                        icon: const Icon(Icons.visibility_off_outlined),
                      ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ConfirmActionButton(
                    padding: EdgeInsets.zero,
                    fixedSize: true,
                    backGroundColor: Styles.kStandardDelete,
                    label: 'Voltar',
                    labelColor: Styles.kStandardWhite,
                    onPressed: () => widget.isAuthPage
                        ? Navigator.pop(context)
                        : CoreUtils.unNamedRouteNavigation(
                            page: const AuthPage(), context: context),
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is SignInSuccess) {
                        setState(() => isLoading = !isLoading);
                        CoreUtils.unNamedRouteNavigation(
                          page: const MyHomePage(),
                          context: context,
                        );
                      } else if (state is AuthLoading) {
                        setState(() => isLoading = !isLoading);
                      } else if (state is AuthError) {
                        setState(() => isLoading = !isLoading);
                        CoreUtils.showSnackBar(
                          context: context,
                          message: state.message,
                          isFailure: true,
                        );
                      }
                    },
                    child: ConfirmActionButton(
                      isLoading: isLoading,
                      padding: EdgeInsets.zero,
                      fixedSize: true,
                      backGroundColor: Styles.kPrimaryYellow,
                      label: 'Entrar',
                      onPressed: () => signIn(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.blocProvider<AuthBloc>().add(
            SignInEvent(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }
}
