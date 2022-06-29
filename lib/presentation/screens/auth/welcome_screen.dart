// ignore_for_file: prefer_const_constructors, unnecessary_const, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '/presentation/bloc/auth/welcome_screen_bloc.dart';
import '/presentation/colors.dart';
import '/presentation/screens/auth/login_screen.dart';
// import '/presentation/screens/registration/registration_employer_screen.dart';
// import '/presentation/screens/registration/registration_model_screen.dart';
import '/presentation/widgets/email_field.dart';
import '/presentation/widgets/green_button.dart';
import '/router/router_cubit.dart';

import '../../widgets/custom_dialog_box.dart';

class WelcomeScreen extends StatefulWidget {
  final http.Client? client;
  final String text;
  const WelcomeScreen({Key? key, this.client, required this.text})
      : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late WelcomeScreenBloc bloc;
  var isAgree = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = WelcomeScreenBloc(client: widget.client, type: widget.text);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0.0,
            toolbarHeight: 0),
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Добро пожаловать",
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: "GloryBold",
                      fontWeight: FontWeight.bold,
                      color: sharkColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Пожалуйста, войдите или зарегистрируйтесь, чтобы продолжить ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GloryMedium",
                      color: Colors.grey),
                ),
              ),
              EmailField(controller: emailController),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Пароль",
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
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                obscureText: true,
                enableSuggestions: false,
                controller: passwordController,
                autocorrect: false,
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
              const SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: vikingColor,
                title: const Text(
                    "Создавая учетную запись, вы должны согласиться с условиями использования",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: "GloryMedium",
                        color: silverChaliceColor)),
                value: isAgree,
                onChanged: (newValue) {
                  setState(() {
                    isAgree = newValue!;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              const SizedBox(
                height: 10,
              ),
              BlueButton(
                onPressed: () {
                  runRegistration(context);
                },
                textButton: "Зарегистрироваться",
              ),
              HttpResultWidget(),
              const SizedBox(
                height: 10,
              ),
              SvgPicture.asset("assets/images/ic_or.svg"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width, // <-- Your width
                height: 50, // <-- Your height
                child: ElevatedButton.icon(
                  icon: IconButton(
                    icon: SvgPicture.asset("assets/images/ic_google.svg"),
                    onPressed: () {},
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                      primary: Colors.white),
                  label: const Text("С помощью Google",
                      style: TextStyle(
                          color: osloGrayColor,
                          fontFamily: 'GloryRegular',
                          fontSize: 16)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: ElevatedButton.icon(
                        icon: IconButton(
                          icon: SvgPicture.asset("assets/images/ic_apple.svg"),
                          onPressed: () {},
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(right: 24.0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                            primary: osloGrayColor),
                        label: Text("Apple",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'GloryRegular',
                                fontSize: 16)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: ElevatedButton.icon(
                        icon: IconButton(
                          icon: SvgPicture.asset("assets/images/ic_vk.svg"),
                          onPressed: () {},
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(right: 24.0),
                            textStyle: const TextStyle(
                                color: osloGrayColor,
                                fontFamily: 'GloryRegular',
                                fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                            primary: endeavourColor),
                        label: const Text(
                          "VKontakte",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Text("У вас уже есть аккаунт?",
                        style: TextStyle(
                            color: grayColor,
                            fontFamily: 'GloryRegular',
                            fontSize: 16)),
                    const SizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text("Авторизируйтесь",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: codGrayColor,
                              fontFamily: 'GloryMedium',
                              fontSize: 16)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void runRegistration(BuildContext context) {
    if (emailController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ошибка валидации",
              descriptions: "Заполните поле Email",
              text: "Ok",
            );
          });
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ошибка валидации",
              descriptions: "Неверный формат Email",
              text: "Ok",
            );
          });
    } else if (passwordController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ошибка валидации",
              descriptions: "Заполните поле Пароль",
              text: "Ok",
            );
          });
    } else if (!isAgree) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ошибка валидации",
              descriptions:
                  "Создавая учетную запись, вы должны согласиться с условиями использования",
              text: "Ok",
            );
          });
    } else {
      bloc.registration(emailController.text, passwordController.text);
    }
  }
}

class HttpResultWidget extends StatelessWidget {
  HttpResultWidget({Key? key}) : super(key: key);
  late WelcomeScreenBloc bloc;

  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<WelcomeScreenBloc>(context, listen: false);
    return StreamBuilder<WelcomeScreenState>(
        stream: bloc.observeRegistrationState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          final WelcomeScreenState state = snapshot.data!;
          switch (state) {
            case WelcomeScreenState.loading:
              return const LoadingIndicator();
            case WelcomeScreenState.justScreen:
              return Container();
            case WelcomeScreenState.registrationSuccess:
              if (bloc.type == "MODEL") {
                context
                    .read<RouterCubit>()
                    .goToRegistrationModelPage("Flutter is number 1.");
              } else {
                context
                    .read<RouterCubit>()
                    .goToRegistrationEmployerPage("Flutter is number 1.");
              }
              return Container();
            case WelcomeScreenState.registrationError:
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    bloc.errorMessage,
                    style: const TextStyle(color: Colors.redAccent),
                  )
                ],
              );
          }
        });
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          color: vikingColor,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
