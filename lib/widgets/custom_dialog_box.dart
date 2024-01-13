import 'package:flutter/material.dart';
import 'dialog_box_widget.dart';

Future<dynamic> showCustomDialog(
  BuildContext context,
  DialogBoxWidget dialogBoxWidget,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return dialogBoxWidget;
    },
  );
}
