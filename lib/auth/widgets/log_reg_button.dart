import 'package:flutter/material.dart';

class LogRegButton extends StatelessWidget {
  final String nameButton;
  final Function() onTap;

  const LogRegButton({Key? key, required this.nameButton, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.amberAccent,
        ),
        child: Text(
          nameButton,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
