import 'dart:math';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/api/constants.dart';
import '/data/api/models/profile/api_profile_response.dart';
import '/domain/model/post/create_post_request_entity.dart';

class ProfileService {
  final String _baseUrl = ApiConstants.BASE_URL;
  final Dio _dio = Dio();

  Future<ApiProfileResponse> getProfile({required int id}) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers["authorization"] =
        "Bearer ${prefs.getString("TOKEN")}";
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final response = await _dio.get(
      '${_baseUrl}profile/$id/',
    );
    return ApiProfileResponse.fromApi(response.data);
  }

  Future<ApiProfileResponse> getProfileSelf() async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers["authorization"] =
        "Bearer ${prefs.getString("TOKEN")}";
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final response = await _dio.get(
      '${_baseUrl}self-profile/',
    );
    return ApiProfileResponse.fromApi(response.data[0]);
  }

  Future<List<ApiProfileResponse>> getProfiles(
      {String? city, String? type, int? gender}) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers["authorization"] =
        "Bearer ${prefs.getString("TOKEN")}";
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final response = await _dio.get('${_baseUrl}profiles/', queryParameters: {
      if (city != null) 'city': city,
      if (type != null) 'type': type,
      if (gender != null) 'gender': gender
    });
    List<ApiProfileResponse> list = [];
    response.data.asMap().forEach(
        (index, value) => {list.add(ApiProfileResponse.fromApi(value))});
    return list;
  }

  Future<List<ApiProfileResponse>> getTalents({String? city}) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers["authorization"] =
        "Bearer ${prefs.getString("TOKEN")}";
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final response = await _dio.get('${_baseUrl}profiles/get-profiles-rating/',
        queryParameters: {'city': city});
    List<ApiProfileResponse> list = [];
    response.data.asMap().forEach(
        (index, value) => {list.add(ApiProfileResponse.fromApi(value))});
    return list;
  }

  Future<Response> createPost(CreatePostRequestEntity body) async {
    DateFormat dateFormatTo = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateFormat dateFormatFrom = DateFormat("dd.MM.yyyy");
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers["authorization"] =
        "Bearer ${prefs.getString("TOKEN")}";
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    var formData = FormData.fromMap({
      'title': body.title,
      'execution_date':
          dateFormatTo.format(dateFormatFrom.parse(body.executionDate)),
      'budget': body.budget,
      'city': body.city,
      'performer_gender': body.performerGender,
      'age_from': body.ageFrom,
      'age_to': body.ageTo,
      'growth_from': body.growthFrom,
      'growth_to': body.growthTo,
      'is_tatoo_or_piercings': body.isTattooOrPiercings,
      'is_foreign_passport': body.isForeignPassport,
      'other_details': body.otherDetails,
      'category': body.category,
    });
    body.photos.asMap().forEach((index, value) => {
          formData.files.addAll([
            MapEntry(
                "photo[$index]",
                MultipartFile.fromFileSync(value.path,
                    filename: "${getRandomString(15)}.jpg"))
          ])
        });
    final response = await _dio.post('${_baseUrl}posts/', data: formData);
    return response;
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
