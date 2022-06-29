import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/api/constants.dart';

import '../models/post/api_post_response.dart';

class PostService {
  final String _baseUrl = ApiConstants.BASE_URL;
  final Dio _dio = Dio();

  Future<ApiPostResponse> getPostById(int id) async {
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
      '${_baseUrl}posts/$id/',
    );
    return ApiPostResponse.fromApi(response.data);
  }

  Future<List<ApiPostResponse>> getPosts({String? city}) async {
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
    final response =
        await _dio.get('${_baseUrl}posts/', queryParameters: {'city': city});
    List<ApiPostResponse> list = [];
    response.data
        .asMap()
        .forEach((index, value) => {list.add(ApiPostResponse.fromApi(value))});
    return list;
  }
}
