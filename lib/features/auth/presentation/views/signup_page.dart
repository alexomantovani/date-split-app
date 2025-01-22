import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/core_utils.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/features/auth/presentation/views/signin_page.dart';
import 'package:date_split_app/features/auth/presentation/widgets/auth_background.dart';
import 'package:date_split_app/core/common/widgets/confirm_action_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

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
                controller: nameController,
                hintText: 'Nome',
                filled: true,
                fillColour: Styles.kStandardLightGrey,
                suffixIcon: const Icon(
                  Icons.person_outline_outlined,
                ),
              ),
              const SizedBox(height: 20.0),
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
                    onPressed: () => Navigator.pop(context),
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        setState(() => isLoading = !isLoading);
                        CoreUtils.unNamedRouteNavigation(
                            page: const SigninPage(isAuthPage: false),
                            context: context);
                        CoreUtils.showSnackBar(
                          context: context,
                          message: state.message!,
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
                      label: 'Confirmar',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.blocProvider<AuthBloc>().add(
                                SignUpEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  displayName: nameController.text,
                                ),
                              );
                        }
                      },
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
}
