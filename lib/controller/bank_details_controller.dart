import 'dart:convert';
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../network/api/api_clients.dart';
import '../reusable_widgets/custom_text.dart';

class BankDetailsController extends GetxController {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController accountHolderNameController =TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  String? selecteAccountType;
List<String> accountTypeOptions = <String>['SAVINGS', 'SALARY'];
  List<String> ifscCodeSuggestions = [];
  List<Map<String, dynamic>> bankDetailsList = [];
  String? bankNameError;
  String? accountNumberError;
  String? accountHolderNameError;
  String? branchNameError;
  String? ifscCodeError;
  String? accountTypeError;
  bool isVerified = false;
  bool isLoading = false;
  String? customerLeadId;
  late ApiClient apiClient;


  
@override
  void onInit() {
    apiClient = ApiClient();
    super.onInit();
  }

void setCustomerLeadId(String id) {
    customerLeadId = id;
    update(); 
  }

  String? validateFields() {
    bankNameError = null; 
    accountNumberError = null;
    accountHolderNameError = null;
    branchNameError = null;
    ifscCodeError = null;
    accountTypeError = null;

    if (bankNameController.text.isEmpty) {
      bankNameError="Bank name required";
    }
    if (!isValidAccountNumber(accountNumberController.text)) {
      if (accountNumberController.text.isEmpty) {
        accountNumberError = 'Bank A/C number required';
        
      }else{
        accountNumberError = "Enter valid account number";
      }
    }
    if (accountHolderNameController.text.isEmpty) {
       accountHolderNameError="Account holder name required";
    }
    if (branchNameController.text.isEmpty) {
      branchNameError= "Branch name required";
    }
    
    if (ifscCodeController.text.isEmpty) {
       ifscCodeError="IFSC code required";
    }
    // accountType Controller.text
    if (selecteAccountType!.isEmpty) {
      accountTypeError="Account-type required";
    }
     update();
    return bankNameError ?? accountNumberError ?? accountHolderNameError ?? branchNameError ?? ifscCodeError ?? accountTypeError; // Return null if all validations pass
  }

  bool isValidAccountNumber(String accountNumber) {
  final RegExp accountNumberRegExp = RegExp(r'^\d{10,16}$');
  return accountNumberRegExp.hasMatch(accountNumber);
}

// bank API 
void fetchBankDetails(String ifscCode) async {
  isLoading = true;
  update();
  
  const String url = 'https://api.salary4sure.com/sla-get-bank-details-by-ifsc-code';
  print("URL $url");
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
      },
      body: jsonEncode({'ifsc_code': ifscCode}),
    );

    print("Response========>${response.body}");
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Status'] == 1 && data['Data'].isNotEmpty) {
         ifscCodeSuggestions.clear();
         bankDetailsList.clear();
         for (var item in data['Data']) {
          ifscCodeSuggestions.add(item['bank_ifsc'] ?? '');
          bankDetailsList.add(item);
        }         
          var bankDetails = data['Data'][0];
          bankNameController.text = bankDetails['bank_name'] ?? '';
          branchNameController.text = bankDetails['bank_branch'] ?? '';
        update();
      } else {
        ifscCodeSuggestions.clear();
        bankNameController.clear();
        branchNameController.clear();
        update();
      }
    } else {
      ifscCodeSuggestions.clear();
      bankNameController.clear();
        branchNameController.clear();
      update();
    }
  } catch (e) {
    ifscCodeSuggestions.clear();
    bankNameController.clear();
    branchNameController.clear();
    update();
    print('Error fetching bank details: $e');
  } finally {
    isLoading = false;
    update();
  }
}
  // Bank verification  Post API
  void verifyBankAccount() async {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cache-Control': 'no-cache',
    'authorization': 'MTE2MzU3MjY6eFh2OTZlNGdoOW9OdHlxbXRLcmw1NFdTalFXOHVjQkQ=',
  };
  
  isLoading = true;
  update();
  
  try {
    final response = await http.post(
      Uri.parse('https://api.digitap.ai/penny-drop/v2/check-valid'),
      headers: headers,
      body: jsonEncode({
        "ifsc": ifscCodeController.text,
        "accNo": accountNumberController.text,
        "benificiaryName": accountHolderNameController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      // Check if 'model' is not null before accessing its properties
      if (data['model'] != null && data['model']['status'] != null) {
        if (data['model']['status'] == 'SUCCESS') {
          showVerificationSuccessDialog();
          isVerified = true; 
          update();
        } else {
          Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: Colors.white,
            'Error', 'Failed to verify bank account');
        }
      } else {
        Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error', 'Invalid response format');
      }
    } else {
      Get.snackbar(
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
        'Error2', 'Failed to verify bank account: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    Get.snackbar(
      backgroundColor: AppColors.logoRedColor,
      colorText: Colors.white,
      'Error3', 'Failed to verify bank account');
    print('Error verifying bank account: $e');
  } finally {
    isLoading = false; 
    update();
  }
}

void submitBankDetails() async {
  isLoading = true; 
  update();

  const String url = 'https://api.salary4sure.com/sla-customer-add-bank-details';
  
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
      },
      body: jsonEncode({
        // 'customer_lead_id': customerLeadId,
        'customer_lead_id': customerLeadId.toString(),
        'ifsc_code': ifscCodeController.text,
        'account_holder_name': accountHolderNameController.text,
        'bank_name': bankNameController.text,
        'branch_name': branchNameController.text,
        'account_no': accountNumberController.text,
        'account_type':selecteAccountType,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Status'] == 1) {
        Get.snackbar(
          backgroundColor: AppColors.black,
          colorText: AppColors.green,
          'Success', 'Bank details added successfully');
          Get.toNamed(MyAppRoutes.uploadBankStatementScreen);
      } else {
        Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error', 'Failed to add bank details: ${data['Message']}');
      }
    } else {
      Get.snackbar(
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
        'Error', 'Failed to add bank details');
    }
  } catch (e) {
    Get.snackbar(
      backgroundColor: AppColors.logoRedColor,
      colorText: Colors.white,
      'Error', 'Failed to add bank details');
    print('Error adding bank details: $e');
  } finally {
    isLoading = false;
    update();
  }
}
void showVerificationSuccessDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        iconPadding: const EdgeInsets.all(5),
        icon: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 199, 245, 200),
          radius: 50,
          child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 145, 240, 148),
              radius: 40,
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check_circle,
                    size: 50,
                    color: AppColors.black,
                  ))),
        ),
        title: Center(
          child: CustomText(
            textName: 'Verification Successfully',
            fontSize: 20,
            textColor: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
                //  Get.toNamed(MyAppRoutes.aadhaarCardVerificationScreen );
              },
              child: CustomText(
                textName: 'OK',
                fontSize: 18,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }



}
