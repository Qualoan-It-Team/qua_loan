import 'package:http/http.dart';
/*
 * Created by - Chetu India
 * Description - This class is used as the base class for api client
 */
abstract class ApiService {

  ///abstract http postRequest method
  // Future<Response> postRequest({required String endPoint,required dynamic body,String header});

  ///abstract http getRequest method
  Future<Response> getRequest({required String endPoint});

  ///abstract http deleteRequest method
  Future<Response> deleteRequest({required String endPoint});

  ///abstract http putRequest method
  Future<Response> putRequest({required String endPoint, required dynamic body});
}
