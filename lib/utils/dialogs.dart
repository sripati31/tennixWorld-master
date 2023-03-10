// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/routes.dart';
import 'package:TennixWorldXI/constant/themes.dart';

class Dialogs {
  static void showDialogWithOneButton(
    BuildContext? context,
    String? title,
    String? content, {
    String? buttonLabel = "Okay",
    required VoidCallback? onButtonPress(),
    barrierDismissible = true,
  }) {
    showDialog(
      context: context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title!),
          content: Text(content!),
          actions: <Widget>[
            ElevatedButton(
              child: Text(buttonLabel!),
              onPressed: () => onButtonPress != null ? onButtonPress() : Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  static Future<bool> showDialogWithTwoButtons(
    BuildContext? context,
    String? title,
    String? content, {
    String? okButtonText = "Okay",
    String? cancelButtonText = "Cancel",
    barrierDismissible = true,
  }) async {
    bool isConfirmed = false;
    await showDialog(
      context: context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: new Text(title!),
          content: new Text(content!),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text(okButtonText!),
              onPressed: () {
                Navigator.pop(buildContext);
                isConfirmed = true;
              },
            ),
            new ElevatedButton(
              child: new Text(cancelButtonText!),
              onPressed: () {
                Navigator.pop(buildContext);
                isConfirmed = false;
              },
            )
          ],
        );
      },
    );
    return isConfirmed;
  }

  static void showDeadlineDialogWithOneButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: new Text(
            'The deadline has passed!',
          ),
          content: new Text(
            "Check out the contests you've joined for this match.",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: AppConstant.SIZE_TITLE16,
            ),
          ),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text(
                "Ok",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  fontSize: AppConstant.SIZE_TITLE18,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    ).then((onValue) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.TAB, (Route<dynamic> route) => false);
    });
  }
}
