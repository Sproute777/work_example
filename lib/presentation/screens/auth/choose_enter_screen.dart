import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/presentation/colors.dart';
// import '/presentation/screens/announcement/announcement_screen.dart';
// import '/presentation/screens/auth/welcome_screen.dart';

import '../../../router/router_cubit.dart';

class ChooseEnterScreen extends StatefulWidget {
  const ChooseEnterScreen({Key? key}) : super(key: key);

  @override
  State<ChooseEnterScreen> createState() => _ChooseEnterScreenState();
}

class _ChooseEnterScreenState extends State<ChooseEnterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SvgPicture.asset("assets/images/ic_logo_choose_screen.svg"),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Кто вы?",
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: "GloryBold",
                    fontWeight: FontWeight.w700,
                    color: sharkColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GloryMedium",
                      color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () => {
                setPrefs('MODEL'),
                context.read<RouterCubit>().goToWelcomePage("MODEL")
              },
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(left: 30, right: 30),
                padding: const EdgeInsets.only(
                    left: 18, right: 20, top: 12, bottom: 14),
                decoration: BoxDecoration(
                    color: vikingColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Wrap(
                  spacing: 0, // to apply margin in the main axis of the wrap
                  runSpacing: 0, //
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Модель",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "GloryMedium",
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Найти работу никогда не было так \nпросто",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "GloryRegular",
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(
                            "assets/images/ic_arrow_next_button_model.svg"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setPrefs('HIRER');
                context.read<RouterCubit>().goToWelcomePage("HIRER");
              },
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(left: 30, right: 30),
                padding: const EdgeInsets.only(
                    left: 18, right: 20, top: 12, bottom: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: mintTulipColor)),
                child: Wrap(
                  spacing: 0, // to apply margin in the main axis of the wrap
                  runSpacing: 0, //
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Работодатель",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "GloryMedium",
                            color: vikingColor),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Найдите подходящую модель или \nфотографа",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "GloryRegular",
                                color: vikingColor),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(
                            "assets/images/ic_arrow_next_button_worker.svg"),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  setPrefs(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('TYPE', type);
  }
}
