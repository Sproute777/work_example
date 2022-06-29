import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
// import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '/presentation/bloc/auth/enter_code_forgot_password_screen_bloc.dart';
import '/presentation/screens/auth/create_new_passwrod_screen.dart';
import '/presentation/widgets/custom_dialog_box.dart';

import '../../colors.dart';
import '../../widgets/green_button.dart';
import '../../widgets/loading.dart';

class EnterCodeForgotPasswordScreen extends StatefulWidget {
  const EnterCodeForgotPasswordScreen({Key? key, required this.email})
      : super(key: key);
  final String email;

  @override
  State<EnterCodeForgotPasswordScreen> createState() =>
      _EnterCodeForgotPasswordScreenState();
}

class _EnterCodeForgotPasswordScreenState
    extends State<EnterCodeForgotPasswordScreen> {
  var smsCodeController = TextEditingController();
  var currentText = "";
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  var email = "";

  late EnterCodeForgotPasswordScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = EnterCodeForgotPasswordScreenBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = widget.email;
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
                          padding: EdgeInsets.only(left: 10, bottom: 10.0),
                          child: Text(
                            "Код подтверждения",
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
                        "assets/images/ic_enter_code_forgot_password.svg"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Пожалуйста, введите 4-значный код, отправленный на",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "GloryMedium",
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 5.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "GloryMedium",
                              color: vikingColor),
                        ),
                      ),
                    ),
                    // PinCodeFields(
                    //   length: 4,
                    //   fieldBorderStyle: FieldBorderStyle.Square,
                    //   responsive: false,
                    //   fieldHeight: 65.0,
                    //   fieldWidth: 50.0,
                    //   borderWidth: 1.0,
                    //   controller: smsCodeController,
                    //   activeBorderColor: vikingColor,
                    //   activeBackgroundColor: Colors.white,
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   keyboardType: TextInputType.number,
                    //   autoHideKeyboard: false,
                    //   fieldBackgroundColor: Colors.white,
                    //   borderColor: mintTulipColor,
                    //   textStyle: const TextStyle(
                    //       fontSize: 24.0, fontFamily: "GloryMedium"),
                    //   onComplete: (output) {
                    //     // Your logic with pin code
                    //     print(output);
                    //   },
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Я не получил код.",
                          style: TextStyle(
                              fontFamily: "GloryMedium", fontSize: 16),
                        ),
                        Text(" Отправить код еще раз",
                            style: TextStyle(
                                fontFamily: "GloryMedium",
                                fontSize: 16,
                                color: vikingColor)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return GestureDetector(
                            onTap: () {
                              bloc.sendRepeatCode(widget.email);
                            },
                            child: const Text('Отправить еще раз',
                                style: TextStyle(
                                    fontFamily: "GloryMedium",
                                    fontSize: 16,
                                    color: vikingColor)),
                          );
                        }
                        return Text('Осталось ${time.sec} секунд',
                            style: const TextStyle(
                                fontFamily: "GloryMedium",
                                fontSize: 16,
                                color: vikingColor));
                      },
                    ),
                    StateContentWidget(widget.email),
                    Flexible(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 15.0, bottom: 65.0),
                          child: BlueButton(
                              onPressed: () {
                                if (smsCodeController.text.isEmpty ||
                                    smsCodeController.text.length < 4) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CustomDialogBox(
                                          title: "Ошибка ввода",
                                          descriptions:
                                              "Введите правильный код",
                                          text: "Ok",
                                        );
                                      });
                                } else {
                                  bloc.sendEmailCode(
                                      email, smsCodeController.text);
                                }
                              },
                              textButton: "Подтвердить"),
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
}

class StateContentWidget extends StatefulWidget {
  const StateContentWidget(this.email, {Key? key}) : super(key: key);
  final String email;

  @override
  State<StateContentWidget> createState() => _StateContentWidgetState();
}

class _StateContentWidgetState extends State<StateContentWidget> {
  @override
  Widget build(BuildContext context) {
    final EnterCodeForgotPasswordScreenBloc bloc =
        Provider.of<EnterCodeForgotPasswordScreenBloc>(context, listen: false);
    return StreamBuilder<EnterCodeForgotPasswordScreenState>(
        stream: bloc.observeAuthState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          final EnterCodeForgotPasswordScreenState state = snapshot.data!;
          switch (state) {
            case EnterCodeForgotPasswordScreenState.loading:
              return const LoadingIndicator();
            case EnterCodeForgotPasswordScreenState.sendEmailCodeError:
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
            case EnterCodeForgotPasswordScreenState.sendEmailCodeScreen:
              return const SizedBox();
            case EnterCodeForgotPasswordScreenState.sendEmailCodeSuccess:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNewPasswordScreen(
                          email: bloc.email, token: bloc.token)),
                );
              });
              return Container();
          }
        });
  }
}
