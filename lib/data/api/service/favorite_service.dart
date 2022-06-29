import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/data/api/constants.dart';
import '/data/api/models/favorite/api_favorite_response.dart';

class FavoriteService {
  final String _baseUrl = ApiConstants.BASE_URL;
  final Dio _dio = Dio();

  Future<List<ApiFavoriteResponse>> getFavorites() async {
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
      '${_baseUrl}get-reply-for-model/',
    );
    List<ApiFavoriteResponse> list = [];
    response.data.asMap().forEach(
        (index, value) => {list.add(ApiFavoriteResponse.fromApi(value))});
    return list;
  }
}
