import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlueButton extends StatelessWidget {
  final VoidCallback? onTap;

  const BlueButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: const Color(0xff6CC9E0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: Text(
              'Отменить отклик',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'GloryMedium',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}