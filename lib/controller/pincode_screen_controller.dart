
import 'dart:convert';
import 'package:app_here/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PinCodeController extends GetxController {
  
  
  var isLoading = false.obs;
  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  String?pincode;




  bool isPincodeComplete() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

// pincode api method  3rd paty
  // void fetchLocation(String pincode) async {
  //   isLoading.value = true; // Set loading to true before the API call
  //   try {
  //     final response = await http
  //         .get(Uri.parse('https://api.postalpincode.in/pincode/$pincode'));
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       if (data[0]['Status'] == 'Success') {
  //         final postOffice = data[0]['PostOffice'];
  //         if (postOffice.isNotEmpty) {
  //           cityController.text = postOffice[0]['Name']; // Set the city
  //           stateController.text = postOffice[0]['State']; // Set the state
  //         } else {
  //           cityController.text = 'Not Found';
  //           stateController.text = 'Not Found';
  //         }
  //       } else {
  //         cityController.text = 'Not Found';
  //         stateController.text = 'Not Found';
  //       }
  //     } else {
  //       cityController.text = 'Error: ${response.statusCode}';
  //       stateController.text = 'Error: ${response.statusCode}';
  //     }
  //   } catch (e) {
  //     cityController.text = 'Error';
  //     stateController.text = 'Error';
  //   } finally {
  //     isLoading.value = false; // Set loading to false after the API call
  //   }
  // }


//  fetch location using pincode method
void fetchLocation(String pincode) async {
  isLoading.value = true;
  try {
    final response = await http.post(
      Uri.parse('https://api.salary4sure.com/sla-get-pincode'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
      },
      body: json.encode({'pincode': pincode}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      if (data['Status'] == 1) {
        if (data['Data'] != null && data['Data'].isNotEmpty) {
          // Fill city and state from the response
          cityController.text = data['Data'][0]['city_name'] ?? 'City Not Found'; // Adjust based on actual response structure
          stateController.text = data['Data'][0]['state_name'] ?? 'State Not Found'; // Adjust based on actual response structure

        } else {
          Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
          'Information', data['Message'], snackPosition: SnackPosition.TOP);
        }
      } else if (data['Status'] == 0) {
        // Invalid pincode
        cityController.text = 'Invalid Pincode';
        stateController.text = 'Invalid Pincode';
        Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error', data['Message'], snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // Handle unexpected status codes
      Get.snackbar(
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
        'Error', 'Invalid Pincode', snackPosition: SnackPosition.TOP);    }
  } catch (e) {
    cityController.text = 'Error';
    stateController.text = 'Error';
    Get.snackbar('Error', 'An error occurred while fetching location', snackPosition: SnackPosition.BOTTOM);
  } finally {
    isLoading.value = false; // Set loading to false after the API call
  }
}
  //otp on changed method 
  void onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 5) {
        FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
      } else {
        String pincode = otpControllers.map((controller) => controller.text).join('');
        this.pincode=pincode;
        fetchLocation(pincode);
      }
    }
  }

//next postion method for pincode digits
 @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    cityController.dispose();
    stateController.dispose();
    super.onClose();
  }
}

 