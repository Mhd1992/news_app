import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class DioHelper {
  // https://newsapi.org?category=business&apikey=84a9a5a645bc4d73880a09141bf3506d
  static Dio? dio;
 // static String baseUrl = 'https://student.valuxapps.com/api/';
  static String baseUrl = 'https://newsapi.org/';

  static ini() {
    print('initisl');
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        /*    headers: {
          'lang': 'ar',
          'Content-Type': 'application/json',
        },*/
      ),
    );
  }
  static Future<Response> getData(
      {required String url,
        Map<String, dynamic>? query,
         }) async {


    return  await dio!.get(url,queryParameters: query);
  }
/*
  static Future<Response> getData(
      {required String url,
        Map<String, dynamic>? query,
        String lang = 'ar',
        String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'ar',
      'apiKey': ' 84a9a5a645bc4d73880a09141bf3506d'
    }; /// =  BaseOptions(headers: {'lang': 'ar', 'Authorization': token});

    //print(token);

    var response = await dio!.get(url, queryParameters: query) ;

    return response;
  }
*/

  static Future<Response> postDate(
      {required String url,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        String lang = 'ar',
        String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'ar',
      'Authorization': token
    };
    return await dio!.post(url, queryParameters: query, data: data);
  }
}
