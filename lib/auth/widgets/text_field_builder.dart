import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldBuilder extends StatefulWidget {
  final String? errorText;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String hint;
  final String? Function(String? val)? validator;
  final Function(String str)? onSubmit;
  bool? obscureText;

  TextFieldBuilder(
      {Key? key,
      this.errorText,
      this.focusNode,
      required this.controller,
      this.textInputType,
      required this.hint,
      this.validator,
      this.onSubmit,
      this.obscureText})
      : super(key: key);

  @override
  State<TextFieldBuilder> createState() => _TextFieldBuilderState();
}

class _TextFieldBuilderState extends State<TextFieldBuilder> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(
          suffixIcon: widget.obscureText != null
              ? IconButton(
                  icon: Icon(
                    widget.obscureText!
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText!;
                    });
                  },
                )
              : null,
          focusedBorder:
              _outlineInputDecor(Theme.of(context).colorScheme.primary),
          enabledBorder:
              _outlineInputDecor(Theme.of(context).colorScheme.onSurface),
          contentPadding: const EdgeInsets.only(left: 15),
          hintText: widget.hint,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          focusedErrorBorder: _outlineInputDecor(Colors.red),
          errorBorder: _outlineInputDecor(Theme.of(context).colorScheme.error),
          errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
          errorText: widget.errorText),
      maxLines: 1,
      enableSuggestions: true,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(fontWeight: FontWeight.normal),
      keyboardType: widget.textInputType ?? TextInputType.text,
      controller: widget.controller,
    );
  }
}

OutlineInputBorder _outlineInputDecor(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.circular(40),
  );
}
