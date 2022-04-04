import 'package:flutter/material.dart';
import 'package:projects/auth/widgets/email_password_form.dart';

class LogScreen extends StatelessWidget {
  LogScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              'Log in',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            EmailAndPasswordForm(
              globalKey: _key,
              controllerEmail: _emailController,
              controllerPassword: _passwordController,
            ),
            const LogButton(),
          ],
        ),
      ),
    );
  }
}

class LogButton extends StatelessWidget {
  const LogButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.amberAccent,
        ),
        child: const Text(
          'Sign in',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
