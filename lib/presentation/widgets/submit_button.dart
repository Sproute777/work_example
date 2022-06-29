import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onTap;

  const SubmitButton({
    this.onTap,
  });

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
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: const Color(0xff6CC9E0),
              width: 2.5,
            ),
          ),
          child: const Center(
            child: Text(
              'Применить',
              style: TextStyle(
                color: Color(0xff6CC9E0),
                fontSize: 18.0,
                fontFamily: 'GloryRegular',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isRed;
  final String text;

  const CustomButton({
    this.onTap,
    this.isRed = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: isRed == true ? Colors.red : const Color(0xff6CC9E0),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Icon(
                isRed ? Icons.clear : Icons.check,
                color: isRed ? Colors.red : const Color(0xff6CC9E0),
                size: 14,
              ),
              const SizedBox(width: 20),
              Text(
                text,
                style: TextStyle(
                  color: isRed == true ? Colors.red : const Color(0xff6CC9E0),
                  fontSize: 14.0,
                  fontFamily: 'GloryRegular',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
