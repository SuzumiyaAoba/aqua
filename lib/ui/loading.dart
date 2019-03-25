import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CircularProgressIndicator(),
              padding: EdgeInsets.all(20.0),
            ),
            Container(
              child: Text("Loading..."),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
            ),
          ],
        ),
      ),
    );
  }
}
