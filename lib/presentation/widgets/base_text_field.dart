import 'package:flutter/material.dart';
import '/presentation/colors.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.inputType,
      required this.textAlign,
      required this.controller,
      required this.isVisibleTitle})
      : super(key: key);
  final String title;
  final String hintText;
  final TextInputType inputType;
  final TextAlign textAlign;
  final bool isVisibleTitle;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isVisibleTitle,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: "GloryMedium",
                  color: mineShaft2GrayColor),
            ),
          ),
        ),
        Visibility(
          visible: isVisibleTitle,
          child: const SizedBox(
            height: 10,
          ),
        ),
        TextField(
          maxLines: 1,
          keyboardType: inputType,
          textAlign: textAlign,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: silverGrayColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: silverGrayColor,
                  width: 1.5,
                ),
              )),
        ),
      ],
    );
  }
}
