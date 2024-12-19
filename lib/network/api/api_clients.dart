import 'dart:convert';
import 'dart:io';
import 'package:app_here/utils/shared_pref.dart';
import 'package:http/http.dart';
import '../../constants/app_strings.dart';
import '../network_constant.dart';
import 'api_services.dart';
import 'package:http/http.dart' as http;

/*
 * Created by - Chetu India
 * Description - This class is used for handling api request.
 */
class ApiClient implements ApiService {


  

///Singleton instance variable
  static final ApiClient _instance = ApiClient._internal();

///factory constructor
  factory ApiClient(){
    return _instance;
  }

  ///Internal constructor
  ApiClient._internal();

///header passed during api call
  var headers = <String, String>{NetworkConstants.contentTypeKey: NetworkConstants.contentType};

////
// static data created for testing 

///endPoint required
  @override
  Future<Response> deleteRequest({required String endPoint}) async {
    headers[NetworkConstants.authKey] = NetworkConstants.bearer+SharedPrefs.getString(key: AppStrings.prefToken);
    var response = await delete(Uri.parse(endPoint), headers: headers).timeout(const Duration(seconds: 30), onTimeout: () => Response(NetworkConstants.timeout, HttpStatus.requestTimeout));
    return response;
  }

///endPoint required
  @override
  Future<Response> getRequest({required String endPoint}) async {
    headers[NetworkConstants.authKey] = NetworkConstants.bearer+SharedPrefs.getString(key: AppStrings.prefToken);
    var response = await get(Uri.parse(endPoint), headers: headers).timeout(const Duration(seconds: 30), onTimeout: () => Response(NetworkConstants.timeout, HttpStatus.requestTimeout));
    return response;
  }
// postRequest method new 
Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final response = await http.post(
      Uri.parse(endPoint),
      headers: headers ?? {}, // Use the provided headers or an empty map
      body: jsonEncode(body),
    );
    return response;
  }


///endPoint and body are required
  // @override
  // Future<Response> postRequest({required String endPoint, required body}) async {
  //   headers[NetworkConstants.authKey] = NetworkConstants.bearer;
  //   var response = await post(Uri.parse(endPoint),body: jsonEncode(body),).timeout(const Duration(seconds: 30), onTimeout: () => Response(NetworkConstants.timeout, HttpStatus.requestTimeout));

  //   return response;
  // }

///endPoint and body are required
  @override
  Future<Response> putRequest({required String endPoint, required body}) async {
    headers[NetworkConstants.authKey] = NetworkConstants.bearer+SharedPrefs.getString(key: AppStrings.prefToken);
    var response = await put(Uri.parse(endPoint),body: jsonEncode(body), headers: headers).timeout(const Duration(seconds: 30), onTimeout: () => Response(NetworkConstants.timeout, HttpStatus.requestTimeout));
    return response;
  }


}