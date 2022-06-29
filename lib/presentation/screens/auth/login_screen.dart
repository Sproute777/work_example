// ignore_for_file: prefer_const_literals_to_create_immutables

// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/presentation/colors.dart';
import '/presentation/screens/auth/forgot_password_screen.dart';
import '/presentation/screens/main_screen.dart';
import '/presentation/widgets/email_field.dart';
import '/presentation/widgets/green_button.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  final http.Client? client;

  const LoginScreen({Key? key, this.client}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc bloc;
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = AuthBloc(client: widget.client);
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
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0.0,
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Вход",
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
                          "Пожалуйста, введите свой данные",
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
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        enableSuggestions: false,
                        controller: passwordController,
                        autocorrect: false,
                        decoration: InputDecoration(
                            suffixIcon: const ImageIcon(
                              AssetImage(
                                  "assets/images/ic_check_text_field.png"),
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
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()),
                          );
                        },
                        child: const Text("Забыли пароль?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: codGrayColor,
                                fontFamily: 'GloryMedium',
                                fontSize: 16)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlueButton(
                        onPressed: () {
                          bloc.login(
                              emailController.text, passwordController.text);
                        },
                        textButton: "Войти",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //Center Row contents horizontally,
                          children: <Widget>[
                            const Text("Нет аккаунта?",
                                style: TextStyle(
                                    color: grayColor,
                                    fontFamily: 'GloryRegular',
                                    fontSize: 16)),
                            const SizedBox(
                              width: 4,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text("Зарегистрироваться",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: codGrayColor,
                                      fontFamily: 'GloryMedium',
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const StateContentWidget()
                    ],
                  ),
                ),
              ),
            )));
  }
}

class StateContentWidget extends StatelessWidget {
  const StateContentWidget({Key? key}) : super(key: key);

  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = Provider.of<AuthBloc>(context, listen: false);
    return StreamBuilder<AuthState>(
        stream: bloc.observeAuthState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          final AuthState state = snapshot.data!;
          switch (state) {
            case AuthState.loading:
              return const LoadingIndicator();
            case AuthState.loadingError:
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    bloc.errorMessage,
                    style: const TextStyle(color: Colors.redAccent),
                  )
                ],
              );
            case AuthState.loginScreen:
              return const SizedBox();
            case AuthState.loginSuccess:
              myCallback(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MainScreen(
                          tabName: 'home',
                        )));
              });
              return Container();
          }
        });
  }
}
