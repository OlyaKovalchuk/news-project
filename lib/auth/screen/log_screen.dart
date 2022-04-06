import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/bloc/log_bloc/log_bloc.dart';
import 'package:projects/auth/bloc/log_bloc/log_state.dart';
import 'package:projects/auth/service/user_repository.dart';
import 'package:projects/auth/widgets/email_password_form.dart';
import 'package:projects/auth/widgets/log_reg_button.dart';

import '../../news/screen/main_screen.dart';
import '../../utils/error_output.dart';
import '../bloc/log_bloc/log_event.dart';

class LogScreen extends StatelessWidget {
  LogScreen({Key? key}) : super(key: key);

  final LogBloc _logBloc = LogBloc(UserRepositoryImpl());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocConsumer(
            bloc: _logBloc,
            builder: (context, LoginState state) {
              if(state is LogSuccess){
                return NewsScreen();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Log in',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  EmailAndPasswordForm(
                    globalKey: _key,
                    controllerEmail: _emailController,
                    controllerPassword: _passwordController,
                    focusNode: _focusNode,
                  ),
                  LogRegButton(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        _logBloc.add(LoginWithCredentials(
                            password: _passwordController.text,
                            email: _emailController.text));
                      }
                    },
                    nameButton: 'Sign in',
                  ),
                ],
              );
            },
            listener: (BuildContext context, LoginState state) {
              if (state is LogFailed) {
                errorOutput(error: state.error, context: context);
              }
            },
          )),
    );
  }
}
