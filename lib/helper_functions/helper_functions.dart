import 'package:flutter/material.dart';

//show snackbar massege
void showsnackbar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

//show loading icon
void showLoadingIcon(BuildContext dialogContext) {
  showDialog(
    context: dialogContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}
