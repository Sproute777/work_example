import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/presentation/bloc/auth/create_new_passwrod_screen_bloc.dart';
import '/presentation/colors.dart';
import '/presentation/screens/auth/login_screen.dart';
import '/presentation/widgets/custom_dialog_box.dart';
import '/presentation/widgets/green_button.dart';

import '../../widgets/loading.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen(
      {Key? key, required this.email, required this.token})
      : super(key: key);
  final String email;
  final String token;

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  var repeatPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  late CreateNewPasswordScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CreateNewPasswordScreenBloc();
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
                          "Создать пароль",
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
                      "assets/images/ic_create_new_password_screen_logo.svg"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Ваш новый пароль должен отличаться от ранее использованного пароля",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "GloryMedium",
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Новый пароль",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: "GloryMedium",
                            color: vikingColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      enableSuggestions: false,
                      controller: newPasswordController,
                      autocorrect: false,
                      decoration: InputDecoration(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Подтвердить пароль",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: "GloryMedium",
                            color: vikingColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      enableSuggestions: false,
                      controller: repeatPasswordController,
                      autocorrect: false,
                      decoration: InputDecoration(
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
                  ),
                  StateContentWidget(newPasswordController.text,
                      repeatPasswordController.text),
                  Flexible(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 15.0, bottom: 65.0),
                        child: BlueButton(
                            onPressed: () {
                              createNewPassword(
                                  widget.email,
                                  widget.token,
                                  newPasswordController.text,
                                  repeatPasswordController.text);
                            },
                            textButton: "Сохранить пароль"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createNewPassword(
      String email, String token, String password, String repeatPassword) {
    if (password.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              title: "Ошибка ввода",
              descriptions: "Заполните поле Пароль",
              text: "Ok",
            );
          });
    } else if (repeatPassword.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              title: "Ошибка ввода",
              descriptions: "Заполните поле Повторить пароль",
              text: "Ok",
            );
          });
    } else if (password != repeatPassword) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              title: "Ошибка ввода",
              descriptions: "Пароли не равны",
              text: "Ok",
            );
          });
    } else {
      bloc.createNewPassword(email, token, password, repeatPassword);
    }
  }
}

class StateContentWidget extends StatelessWidget {
  const StateContentWidget(this.password, this.repeatPassword, {Key? key})
      : super(key: key);
  final String password;
  final String repeatPassword;

  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CreateNewPasswordScreenBloc bloc =
        Provider.of<CreateNewPasswordScreenBloc>(context, listen: false);
    return StreamBuilder<CreateNewPasswordScreenState>(
        stream: bloc.observeState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          final CreateNewPasswordScreenState state = snapshot.data!;
          switch (state) {
            case CreateNewPasswordScreenState.loading:
              return const LoadingIndicator();
            case CreateNewPasswordScreenState.createNewPasswordError:
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
            case CreateNewPasswordScreenState.createNewPasswordScreen:
              return const SizedBox();
            case CreateNewPasswordScreenState.createNewPasswordSuccess:
              myCallback(() {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginScreen()),
                    ModalRoute.withName('/'));
              });
              return Container();
          }
        });
  }
}
