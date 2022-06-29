import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// UI Component, for App bar's reusable button items
class MenuButton extends StatelessWidget {
  final String iconPath;

  const MenuButton({
    Key? key,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: Center(
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5.0),
                blurRadius: 15.0,
                color: Colors.black.withOpacity(0.1),
              )
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 16.0,
              height: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
