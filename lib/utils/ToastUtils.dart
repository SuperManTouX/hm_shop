import 'package:flutter/material.dart';

class ToastUtils {
  static void showSuccess(BuildContext context,String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 200,
        content: Text(msg),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  static void showError(BuildContext context,String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 200,
        content: Text(msg),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  static void showTest(BuildContext context,String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 200,
        content: Text(msg),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}