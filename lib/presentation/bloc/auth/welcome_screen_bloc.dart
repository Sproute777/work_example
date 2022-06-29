import 'dart:convert';

import 'package:dio/dio.dart';
import "package:http/http.dart" as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/api/constants.dart';

class WelcomeScreenBloc {
  http.Client? client;
  final stateSubject = BehaviorSubject<WelcomeScreenState>();
  var errorMessage = "";
  var type = "";

  Stream<WelcomeScreenState> observeRegistrationState() => stateSubject;

  void dispose() {
    stateSubject.close();
    client?.close();
  }

  WelcomeScreenBloc({this.client, required this.type}) {
    stateSubject.add(WelcomeScreenState.justScreen);
  }

  Future<void> registration(final String email, final String password) async {
    stateSubject.add(WelcomeScreenState.loading);
    final prefs = await SharedPreferences.getInstance();
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    prefs.setString("EMAIL", email);
    prefs.setString("PASSWORD", password);
    Map<String, dynamic> jsonMap = {
      'email': email,
      'password': password,
    };
    // print(jsonMap);
    try {
      const baseUrl = ApiConstants.BASE_URL;
      final response = await dio.post("${baseUrl}check/", data: jsonMap);
      if (response.statusCode == 200) {
        stateSubject.add(WelcomeScreenState.registrationSuccess);
      } else {
        if (jsonDecode(utf8.decode(response.data))
            .toString()
            .contains("email address уже существует")) {
          errorMessage = "Такой email уже существует";
        } else {
          errorMessage = "Ошибка при регистрации";
        }
        stateSubject.add(WelcomeScreenState.registrationError);
        // print(jsonDecode(utf8.decode(response.data)));
      }
    } on Exception catch (_) {
      errorMessage = "Ошибка при регистрации";
      stateSubject.add(WelcomeScreenState.registrationError);
    }
  }
}

enum WelcomeScreenState {
  loading,
  justScreen,
  registrationSuccess,
  registrationError
}
