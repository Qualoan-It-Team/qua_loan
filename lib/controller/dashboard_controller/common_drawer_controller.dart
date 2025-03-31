// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/model/response_model/get_user_profile_response.dart';
import 'package:qualoan/model/response_model/loan_application_details_response.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonDrawerController extends GetxController {
  String? userName;
  String? userProfilePicture;
  bool isLoading = false;
  LoanApplicationDetailsRespons?loanApplicationResponse;
  late ApiClient apiClient;
 
@override
  void onInit() async{
    super.onInit();
    apiClient =ApiClient();
    fetchUserProfile();
   
    
  }
Future<void> openWebPage(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw '${AppStrings.couldNotLaunch} $url';
    }
  }

  
///fetch user profile method
  Future<void> fetchUserProfile() async {
  isLoading = true;
  update();
  try {
     var response = await apiClient.getRequestWithToken( endPoint: EndPoints.localHostGetUserProfileUrl);
   var userResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var getUserProfileResponse = GetUserProfileResponse.fromJson(userResponse);
      if (getUserProfileResponse.success) {
        final data = getUserProfileResponse.data;
        userName=data.name;
        userProfilePicture=data.profileImage??AppStrings.emptyString;
      }
      else{
      showCustomSnackbar(AppStrings.error, AppStrings.failedToFetchProfile ,backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);

      }
    } else {
     showCustomSnackbar(AppStrings.error, AppStrings.failedToFetchProfile ,backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);

    }
  } catch (e) {
    // print("error------$e");
  //  showCustomSnackbar(AppStrings.error, "$e ",backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
  } finally {
    isLoading = false;
    update();
  }
}


//logout api 
Future<void> logout() async {
    isLoading = true;
    update();
    try {
      final response = await apiClient .postRequestWithoutToken( endPoint: EndPoints.localHostLogout,body: {});
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        showCustomSnackbar(AppStrings.successText, " ${response.body}",
            backgroundColor: AppColors.black, textColor: AppColors.green);
        Get.offNamed(MyAppRoutes.signInWithAadhaarScreen);
      } else {
        showCustomSnackbar(AppStrings.error, " ${response.body}",
            backgroundColor: AppColors.logoRedColor, textColor: AppColors.white);
      }
    } catch (e) {
      showCustomSnackbar(AppStrings.error, "$e",
          backgroundColor: AppColors.logoRedColor, textColor: AppColors.white);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}