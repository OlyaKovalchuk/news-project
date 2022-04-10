import 'package:flutter/material.dart';
import 'package:projects/auth/utils/validator.dart';
import 'package:projects/auth/widgets/text_field_builder.dart';

class EmailAndPasswordForm extends StatelessWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final FocusNode focusNode;
  final GlobalKey<FormState> globalKey;

  const EmailAndPasswordForm(
      {Key? key,
      required this.globalKey,
      required this.controllerEmail,
      required this.controllerPassword,
      required this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          TextFieldBuilder(
            focusNode: focusNode,
            controller: controllerEmail,
            textInputType: TextInputType.emailAddress,
            hint: 'Email',
            onSubmit: (email) {
              focusNode.requestFocus();
              focusNode.nextFocus();
            },
            validator: (String? email) => Validators.validEmail(email),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldBuilder(
              validator: (password) => Validators.validPassword(password),
              controller: controllerPassword,
              textInputType: TextInputType.visiblePassword,
              hint: 'Password',
              obscureText: true,
              onSubmit: (password) {
                focusNode.consumeKeyboardToken();
              }),
        ],
      ),
    );
  }
}
