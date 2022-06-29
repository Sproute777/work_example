import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/presentation/bloc/auth/forgot_password_screen_bloc.dart';
import '/presentation/colors.dart';
import '/presentation/screens/auth/enter_code_forgot_password_screen.dart';
import '/presentation/widgets/custom_dialog_box.dart';
import '/presentation/widgets/email_field.dart';
import '/presentation/widgets/green_button.dart';

import '../../widgets/loading.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailController = TextEditingController();
  late ForgotPasswordScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ForgotPasswordScreenBloc();
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
              toolbarHeight: 10),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset("assets/images/ic_back_arrow.png",
                              width: 80, height: 80),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10.0),
                          child: Text(
                            "Забыл пароль",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: "GloryMedium",
                                color: blackPearlColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SvgPicture.asset(
                        "assets/images/ic_forgot_password_logo.svg"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Пожалуйста, введите свой адрес электронной почты, чтобы получить\nкод подтверждения.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "GloryMedium",
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: EmailField(controller: emailController),
                    ),
                    StateContentWidget(emailController.text),
                    Flexible(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 100, left: 15.0, bottom: 65.0),
                          child: BlueButton(
                              onPressed: () {
                                runRegistration(context);
                              },
                              textButton: "Отправлять"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void runRegistration(BuildContext context) {
    if (emailController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
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
            return const CustomDialogBox(
              title: "Ошибка валидации",
              descriptions: "Неверный формат Email",
              text: "Ok",
            );
          });
    } else {
      bloc.registration(emailController.text);
    }
  }
}

class StateContentWidget extends StatelessWidget {
  const StateContentWidget(this.email, {Key? key}) : super(key: key);
  final String email;

  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordScreenBloc bloc =
        Provider.of<ForgotPasswordScreenBloc>(context, listen: false);
    return StreamBuilder<ForgotPasswordScreenState>(
        stream: bloc.observeAuthState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          final ForgotPasswordScreenState state = snapshot.data!;
          switch (state) {
            case ForgotPasswordScreenState.loading:
              return const LoadingIndicator();
            case ForgotPasswordScreenState.sendEmailError:
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Text(
                      bloc.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  )
                ],
              );
            case ForgotPasswordScreenState.sendEmailScreen:
              return const SizedBox();
            case ForgotPasswordScreenState.sendEmailSuccess:
              myCallback(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EnterCodeForgotPasswordScreen(email: bloc.email)),
                );
              });
              return Container();
          }
        });
  }
}
