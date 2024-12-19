/*
 * Created by - Chetu India .
 * Description - This class is used for defining all the constants used in network operation.
 */
class NetworkConstants {
  NetworkConstants._();

  ///Network and API constants
  static const String statusCode = 'statusCode';
  static const String status = 'status';
  static const String statusFlag = 'success';
  static const String message = 'message';
  static const String contentType = 'application/json';
  static const String authKey = 'Authorization';
  static const String noCache = 'no-cache';
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String header = 'Header';
  static const String body = 'Body';
  static const String bearer = 'Bearer ';
  static const String tokenKey = 'Token';
  static const String contentTypeKey = 'Content-Type';
  static const String timeout = 'Timeout';

  ///Error Response Message
  static const String invalidToken = 'Invalid token';
  static const String missingOrInvalidToken = 'Missing or invalid token';

}