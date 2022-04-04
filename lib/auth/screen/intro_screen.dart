import 'package:flutter/material.dart';
import 'package:projects/auth/screen/reg_screen.dart';

import 'log_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.modulate),
          image: AssetImage(
            'assets/images/intro_bg.jpeg',
          ),
          fit: BoxFit.fill,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const TextNews(),
            Column(
              children: const [
                LogButton(),
                RegTextButton(),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class TextNews extends StatelessWidget {
  const TextNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'News',
      style: TextStyle(
          fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class LogButton extends StatefulWidget {
  const LogButton({Key? key}) : super(key: key);

  @override
  _LogButtonState createState() => _LogButtonState();
}

class _LogButtonState extends State<LogButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black54,
            ),
            child: const Text(
              'Log in',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class RegTextButton extends StatefulWidget {
  const RegTextButton({Key? key}) : super(key: key);

  @override
  _RegTextButtonState createState() => _RegTextButtonState();
}

class _RegTextButtonState extends State<RegTextButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Do you not have an account?',
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegScreen()));
            },
            child: const Text('Sign up',
                style: TextStyle(
                    color: Colors.amberAccent, fontWeight: FontWeight.bold)))
      ],
    );
  }
}
