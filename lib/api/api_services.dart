import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enam_dua_teknologi/constant/constant.dart';

class APIServices {
  static Future getApi(String path, String term, CancelToken cancelToken) async {
    String? message;

    BaseOptions baseOptions = BaseOptions(
        baseUrl: urlApi,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        sendTimeout: 15000,
        receiveDataWhenStatusError: true);

    Dio dio = Dio(baseOptions);

    // ignore: unused_local_variable
    Response response;
    try {
      response = await dio.get('$path$term',
          options: Options(headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenYelp',
          }),
          cancelToken: cancelToken);
      return response.data;
    } on SocketException catch (_) {
      return {"success": false, "message": 'No internet connection'};
    } on FormatException catch (e) {
      return {"success": false, "message": e.message};
    } on DioError catch (e) {
      if (e.requestOptions.cancelToken != null) {
        if (e.requestOptions.cancelToken!.isCancelled == true) {
          cancelToken.cancel();
          return null;
        }
      }

      if (e.response != null) {
        return e.response!.data;
      } else {
        if (e.type == DioErrorType.connectTimeout) {
          message = 'Connection timeout';
        } else if (e.type == DioErrorType.receiveTimeout) {
          message = 'Receive timeout';
        } else if (e.type == DioErrorType.sendTimeout) {
          message = 'Send timeout';
        } else if (e.type == DioErrorType.other) {
          message = "Something wen't wrong";
        }
        return {"success": false, "message": message};
      }
    } catch (e) {
      message = "Something wen't wrong";
      return {"success": false, "message": message};
    }
  }



}
