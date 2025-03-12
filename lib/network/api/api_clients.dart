import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:qualoan/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_strings.dart';
import '../network_constant.dart';
import 'api_services.dart';
import 'package:http/http.dart' as http;

/*
 * Created by - Naman pvt ltd India
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
    // headers[NetworkConstants.authKey] = NetworkConstants.bearer+SharedPrefs.getString(/*key: AppStrings.prefToken*/);
    var response = await get(Uri.parse(endPoint), headers: headers).timeout(const Duration(seconds: 30), onTimeout: () => Response(NetworkConstants.timeout, HttpStatus.requestTimeout));
    return response;
  }


//method for token
Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  
  @override
  Future<Response> getRequestWithToken({required String endPoint}) async {
    String? token = await getToken();
    headers[NetworkConstants.authKey] = NetworkConstants.bearer+ token!;
    print("token=====$token");
    var response = await get(Uri.parse(endPoint), headers: headers).timeout(const Duration(seconds: 30), onTimeout: () => Response(NetworkConstants.timeout, HttpStatus.requestTimeout));
    return response;
  }
// postRequest method new 
Future<Response> postRequestWithoutToken({
    required String endPoint,
    required Map<String, dynamic> body,
    // Map<String, String>?headers,
  }) async {
    final response = await http.post(
      Uri.parse(endPoint),
      headers: headers , 
      body: jsonEncode(body),
    );
    return response;
  }


///endPoint and body are required
@override
///this method i created for dynamic header and token 
  Future<Response> postRequestWithToken({required String endPoint, required body}) async {
    String? token = await getToken();
    headers[NetworkConstants.authKey] = NetworkConstants.bearer+token!;
    print("Token.........$token");
    // SharedPrefs.getString(key: AppStrings.token);
    var response = await post(Uri.parse(endPoint),body: jsonEncode(body), headers: headers).timeout(const Duration(seconds: 30), onTimeout: () => Response(NetworkConstants.timeout, HttpStatus.requestTimeout));

    return response;
  }
  // @override
  // Future<Response> postRequest({required String endPoint, required body ,/*required String header*/}) async {
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
/////implementation
 Future<bool> isTokenValid() async {
    String? token = await getToken();
    // Here you can add logic to check if the token is expired
    return token != null; // Adjust this logic based on your token expiration strategy
  }

  // Future<Response> getRequestWithToken({required String endPoint}) async {
  //   if (!await isTokenValid()) {
  //     // Handle token expiration (e.g., navigate to login screen)
  //     throw Exception("Token is invalid or expired");
  //   }

}