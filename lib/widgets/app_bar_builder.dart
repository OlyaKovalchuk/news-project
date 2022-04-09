import 'package:flutter/material.dart';

AppBar appBarBuilder({Widget? leading, List<Widget>? actions, String? title}) =>
    AppBar(
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: false,
      title: Text(
        title ?? '',
      ),
    );
