import 'package:flutter/material.dart';
import '/presentation/colors.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 50,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Эл. адрес",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: "GloryMedium",
                color: vikingColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: const ImageIcon(
                AssetImage("assets/images/ic_check_text_field.png"),
                color: vikingColor,
              ),
              contentPadding: const EdgeInsets.all(18),
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
