import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/bloc/reg_bloc/reg_bloc.dart';
import 'package:projects/auth/bloc/reg_bloc/reg_event.dart';
import 'package:projects/auth/bloc/reg_bloc/reg_state.dart';
import 'package:projects/auth/service/user_repository.dart';
import 'package:projects/auth/utils/validator.dart';
import 'package:projects/auth/widgets/email_password_form.dart';
import 'package:projects/auth/widgets/log_reg_button.dart';
import 'package:projects/auth/widgets/text_field_builder.dart';
import 'package:projects/news/screen/all_news_screen.dart';
import 'package:projects/utils/error_output.dart';

class RegScreen extends StatelessWidget {
  RegScreen({Key? key}) : super(key: key);
  final RegBloc _regBloc = RegBloc(UserRepositoryImpl());

  final _focusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _regBloc,
      builder: (context, state) {
        if (state is RegSuccess) {
          return const AllNewsScreen();
        }
        return Scaffold(
            backgroundColor: Colors.grey.shade800,
            appBar: AppBar(
              backgroundColor: Colors.grey.shade900,
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Registration',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    TextFieldBuilder(
                      onSubmit: (_) {
                        _focusNode.requestFocus();
                      },
                      controller: _nameController,
                      textInputType: TextInputType.name,
                      hint: 'Name',
                      validator: (String? name) => Validators.validName(name),
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
                          _regBloc.add(RegWithCredentialsPressed(
                              password: _passwordController.text,
                              email: _emailController.text,
                              name: _nameController.text));
                        }
                      },
                      nameButton: 'Sign up',
                    ),
                  ],
                )));
      },
      listener: (BuildContext context, RegState state) {
        if (state is RegFailed) {
          errorOutput(error: state.error, context: context);
        }
      },
    );
  }
}
