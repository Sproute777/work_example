import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/data/api/constants.dart';
import '/di/post_di.dart';
import '/domain/model/profile/profile_entity.dart';
import '/domain/repository/profile_repository.dart';

class AuthBloc {

  http.Client? client;
  final stateSubject = BehaviorSubject<AuthState>();
  var errorMessage = "";
  final ProfileRepository _repository = serviceDiPost<ProfileRepository>();
  Stream<AuthState> observeAuthState() => stateSubject;

  AuthBloc({this.client}){
    stateSubject.add(AuthState.loginScreen);
  }

  void dispose() {
    stateSubject.close();
    client?.close();
  }

  Future<void> login(final String email, final String password) async {
    stateSubject.add(AuthState.loading);
    final baseUrl = ApiConstants.BASE_URL;
    Map<String, dynamic> jsonMap = {
      'email': email,
      'password': password,
    };
    print(Uri.parse("${baseUrl}token/obtain/"));
    final response = await (client ??= http.Client())
        .post(Uri.parse("${baseUrl}token/obtain/"), body: jsonMap);
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print(decoded);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('TOKEN', decoded['access']);
      getProfile();
    } else {
      print(response);
      errorMessage = "Ошибка авторизации";
      stateSubject.add(AuthState.loadingError);
    }
  }

  Future<void> getProfile() async {
    stateSubject.add(AuthState.loading);
    try {
      ProfileEntity? data = await _repository.getProfileSelf();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('IS_AUTH', true);
      await prefs.setString('TYPE', data!.userType);
      stateSubject.add(AuthState.loginSuccess);
    } on Exception {
      errorMessage = "Ошибка авторизации";
      stateSubject.add(AuthState.loadingError);
    }
  }

}

enum AuthState {
  loading,
  loginSuccess,
  loadingError,
  loginScreen,
}