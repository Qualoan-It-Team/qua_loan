
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:qualoan/view/dashboard/common_drawer.dart';
import 'package:qualoan/view/dashboard/loan_status.dart';
import 'package:qualoan/view/dashboard/view_profile_screen.dart';
import 'package:qualoan/view/loan_application/loan_application.dart';
import 'package:qualoan/view/loan_application/loan_calculator.dart';
import 'package:qualoan/view/dashboard/home_screen.dart';
import 'package:qualoan/view/loan_application/bank_details_verification.dart';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';
import 'package:qualoan/view/loan_application/employment_information.dart';
import 'package:qualoan/view/dashboard/calculator.dart';
import 'package:qualoan/view/login_functionality/aadhaar_signin_otp_screen.dart';
import 'package:qualoan/view/dashboard/question_answer_screen.dart';
import 'package:qualoan/view/login_functionality/aadhaar_signin_screen.dart';
import 'package:qualoan/view/registration/address_information.dart';
import 'package:qualoan/view/registration/income_information.dart';
import 'package:qualoan/view/registration/mobile_number_verification.dart';
import 'package:qualoan/view/registration/mobile_otp_verification.dart';
import 'package:qualoan/view/registration/personal_information.dart';
import 'package:qualoan/view/registration/registration_form.dart';
import 'package:qualoan/view/registration/upload_selfie.dart';
import 'package:qualoan/view/splash_screen.dart';
import 'package:qualoan/view/loan_application/upload_bank_statement.dart';

class MyAppRoutes {
  static const String splashScreen = '/';
  // login routing
  static const String signInWithAadhaarScreen = "/signInWithAadhaarScreen";
  static const String aadhaarSignInOtpScreen = "/aadhaarSigninOtpScreen";
  // dashboard routing
  static const String dashboardScreen = "/dashboardScreen";
  static const String homeScreen = "/homeScreen";
  static const String calculatorScreen = "/calculatorScreen";
  static const String questionAnswerScreen = "/questionAnswerScreen";
  static const String loanStatus = "/loanStatus";
  static const String viewProfile = "/viewProfile";
  static const String commonDrawer = "/commonDrawer";
  //loan application routing
  static const String loanCalculatorScreen = "/loanCalculatorScreen";
  static const String loanApplication = "/loanApplication";
  static const String employmentVerificationScreen ="/employmentVerificationScreen";
  static const String bankDetails = "/bankDetails";
  static const String uploadBankStatementScreen = "/uploadBankStatementScreen";
  //registration
  static const String addressInformation = "/addressInformation";
  static const String incomeInformation = "/incomeInformation";
  static const String mobileNumberVerification = "/mobileNumberVerification";
  static const String mobileOtpVerification = "/mobileOtpVerification";
  static const String personalInformation = "/personalInformation";
  static const String registrationForm = "/registrationForm";
  static const String uploadSelfie = "/uploadSelfie";

  static final List<GetPage> pages = [
    //login
    GetPage(name: MyAppRoutes.splashScreen,page: ()=> const SplashScreen(),transition:Transition.fadeIn,transitionDuration: const Duration(seconds:3)),
    GetPage(name: MyAppRoutes.signInWithAadhaarScreen,page: ()=>SignInWithAadhaarScreen()),
    GetPage(name: MyAppRoutes.aadhaarSignInOtpScreen, page: () =>AadhaarSignInOtpScreen()),
    //dashboard
    GetPage(name: MyAppRoutes.dashboardScreen,page:() =>DashboardScreen()),
    GetPage(name: MyAppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage( name: MyAppRoutes.calculatorScreen,page: () => CalculatorScreen()),
    GetPage(name: MyAppRoutes.questionAnswerScreen,page: () => QuestionAnswerScreen()),
    GetPage(name: MyAppRoutes.loanStatus,page: () => LoanStatus()),
    GetPage(name: MyAppRoutes.viewProfile,page: () =>   ViewProfileScreen()),
    GetPage(name: MyAppRoutes.commonDrawer,page: () => CommonDrawer()),
    GetPage(name: MyAppRoutes.questionAnswerScreen,page: () => QuestionAnswerScreen()),
    //loan application
    GetPage( name: MyAppRoutes.employmentVerificationScreen,page: () => EmploymentInformation()),
    GetPage( name: MyAppRoutes.loanApplication,page: () => LoanApplicationScreen()),
    GetPage( name: MyAppRoutes.loanCalculatorScreen,page: () => LoanCalculator()),
    GetPage( name: MyAppRoutes.bankDetails,page: () => BankDetailsVerification()),
    GetPage(name: MyAppRoutes.uploadBankStatementScreen,page: () =>  UploadBankStatement()),
    // registration
    GetPage(name: MyAppRoutes.addressInformation,page: () =>  AddressInformation()),
    GetPage(name: MyAppRoutes.incomeInformation,page: () =>   IncomeInformation()),
    GetPage(name: MyAppRoutes.mobileNumberVerification,page: () =>  MobileNumberVerification()),
    GetPage(name: MyAppRoutes.mobileOtpVerification,page: () =>  MobileOtpVerification()),
    GetPage(name: MyAppRoutes.personalInformation,page: () =>  PersonalInformation()),
    GetPage(name: MyAppRoutes.registrationForm,page: () =>  RegistrationFormScreen()),
    GetPage(name: MyAppRoutes.uploadSelfie,page: () => const UploadSelfieScreen()),
  ];
}
