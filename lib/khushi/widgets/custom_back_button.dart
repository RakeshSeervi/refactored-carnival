import 'package:flutter/material.dart';

import '../constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(
        Size(
          28.0,
          28.0,
        ),
      ),
      decoration: BoxDecoration(
        color: accentColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0.0),
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.chevron_left,
          color: Colors.white,
        ),
      ),
    );
  }
}
