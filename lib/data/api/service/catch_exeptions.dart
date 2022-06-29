import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CatchException {
  String? message;

  CatchException({this.message});

  @override
  String toString() => message!;

  static CatchException convertException(dynamic error) {
    if (error is DioError && error.error is CatchException) {
      return error.error;
    }
    if (error is DioError) {
      debugPrint(error.toString());
      if (error.type == DioErrorType.connectTimeout) {
        debugPrint('CONNECTION_ERROR');
        return CatchException(
            message: 'Привышено время обработки запроса. Повторите позднее');
      } else if (error.type == DioErrorType.receiveTimeout) {
        debugPrint('RECIVE_ERROR');
        return CatchException(
            message: 'Привышено время обработки запроса. Повторите позднее');
      } else if (error.response == null) {
        debugPrint('NO_INTERNET');
        return CatchException(message: 'Нет интернет соеденения');
      } else if (error.response!.statusCode == 401) {
        debugPrint('401 - AUTH ERROR');
        return CatchException(message:  error.response!.data["detail"]);
      } else if (error.response!.statusCode == 400) {
        return CatchException(message: error.response!.data["detail"]);
      } else {
        return CatchException(message: 'Произошла системная ошибка');
      }
    }
    if (error is CatchException) {
      return error;
    } else {
      return CatchException(message: 'Произошла системная ошибка');
    }
  }
}
