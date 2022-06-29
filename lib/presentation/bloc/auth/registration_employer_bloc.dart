import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/api/constants.dart';
import '/presentation/models/RequestProfileModel.dart';

class RegistrationEmployerBloc {
  http.Client? client;
  final stateSubject = BehaviorSubject<RegistrationEmployerScreenState>();
  var errorMessage = "";

  Stream<RegistrationEmployerScreenState> observeRegistrationState() =>
      stateSubject;

  void dispose() {
    stateSubject.close();
    client?.close();
  }

  RegistrationEmployerBloc({this.client}) {
    stateSubject.add(RegistrationEmployerScreenState.justScreen);
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> registration(
      RequestProfileModel model, List<File> photos) async {
    final prefs = await SharedPreferences.getInstance();
    stateSubject.add(RegistrationEmployerScreenState.loading);
    var dio = Dio();
    dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final baseUrl = ApiConstants.BASE_URL;
    Map<String, dynamic> jsonMap = {
      'email': prefs.getString("EMAIL"),
      'password': prefs.getString("PASSWORD"),
    };
    print(jsonMap);
    try {
      final response = await dio.post("${baseUrl}register/", data: jsonMap);
      if (response.statusCode == 201) {
        login(prefs.getString("EMAIL")!, prefs.getString("PASSWORD")!, model,
            photos);
      } else {
        if (jsonDecode(utf8.decode(response.data))
            .toString()
            .contains("email address уже существует")) {
          errorMessage = "Такой email уже существует";
        } else {
          errorMessage = "Ошибка при регистрации";
        }
        stateSubject.add(RegistrationEmployerScreenState.registrationError);
        print(jsonDecode(utf8.decode(response.data)));
      }
    } on Exception catch (_) {
      errorMessage = "Ошибка при регистрации";
      stateSubject.add(RegistrationEmployerScreenState.registrationError);
    }
  }

  Future<void> login(final String email, final String password,
      RequestProfileModel model, List<File> photos) async {
    final baseUrl = ApiConstants.BASE_URL;
    Map<String, dynamic> jsonMap = {
      'email': email,
      'password': password,
    };
    final response = await (client ??= http.Client())
        .post(Uri.parse("${baseUrl}token/obtain/"), body: jsonMap);

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print(decoded);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('IS_AUTH', true);
      await prefs.setString('TOKEN', decoded['access']);
      registrationEmployer(model, photos);
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      errorMessage = "Ошибка при регистрации";
      stateSubject.add(RegistrationEmployerScreenState.registrationError);
    }
  }

  Future<void> registrationEmployer(
      RequestProfileModel model, List<File> photos) async {
    stateSubject.add(RegistrationEmployerScreenState.loading);
    final prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      // print(body.toJson());
    }
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
    final baseUrl = ApiConstants.BASE_URL;
    var formData = FormData.fromMap({
      'email': model.email,
      'password': model.password,
      'name': model.name,
      'gender': model.gender,
      'age': model.age,
      'city': model.city,
      'phone': model.phone,
      'instagram': model.instagram,
      'website': model.website,
      'about': model.about,
      'close_size': model.closeSize,
      'shoes_size': model.shoesSize,
      'growth': model.growth,
      'bust': model.bust,
      'waist': model.waist,
      'hips': model.hips,
      'look_type': model.lookType,
      'skin_color': model.skinColor,
      'hair_color': model.hairColor,
      'hair_length': model.hairLength,
      'is_have_international_passport': model.isHaveInternationalPassport,
      'is_have_tattoo': model.isHaveTattoo,
      'is_have_english': model.isHaveEnglish,
      "user_type": "HIRER"
    });
    photos.asMap().forEach((index, value) => {
          formData.files.addAll([
            MapEntry(
                "photos[$index]",
                MultipartFile.fromFileSync(value.path,
                    filename: "${getRandomString(15)}.jpg"))
          ])
        });
    try {
      final response = await dio.post("${baseUrl}profile/",
          data: formData,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${prefs.getString("TOKEN")}'
            },
          ));
      if (response.statusCode == 201) {
        stateSubject.add(RegistrationEmployerScreenState.registrationSuccess);
      } else {
        errorMessage = utf8.decode(response.data);
        stateSubject.add(RegistrationEmployerScreenState.registrationError);
        if (kDebugMode) {
          print(utf8.decode(response.data));
        }
      }
    } on Exception catch (e) {
      errorMessage = e.toString();
      stateSubject.add(RegistrationEmployerScreenState.registrationError);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

enum RegistrationEmployerScreenState {
  loading,
  justScreen,
  registrationSuccess,
  registrationError
}
