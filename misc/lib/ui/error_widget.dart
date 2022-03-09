import 'package:flutter/material.dart';

import '../generated/l10n.dart';

Future showError(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      return const ErrorView();
    });

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: AlertDialog(
          content: Text(
            S().string_oops,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                S().title_retry,
                style: const TextStyle(color: Colors.green),
              ),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green)),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                S().title_close,
                style: const TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red)),
            )
          ],
        ),
      );
}
