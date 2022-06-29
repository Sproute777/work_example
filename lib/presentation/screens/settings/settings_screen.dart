import 'package:flutter/material.dart';

import '/presentation/colors.dart' as color;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Настройки',
            style: TextStyle(
              fontFamily: 'Glory-TSI-Meduim.ttf',
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.athensGrayColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: color.vikingColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/images/example_image.jpeg',
                    height: 60,
                    width: 60,
                    //fit: BoxFit.contain,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Test Test',
                      style: TextStyle(
                        color: color.vikingColor,
                        fontFamily: 'Glory-TSI-Meduim.ttf',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'email@email.com',
                      style: TextStyle(
                        color: color.silverChaliceColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: color.vikingColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
