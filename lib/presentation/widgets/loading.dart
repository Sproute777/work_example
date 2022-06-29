import 'package:flutter/material.dart';

import '../colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: CircularProgressIndicator(
          color: vikingColor,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
