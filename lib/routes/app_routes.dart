import 'package:app_here/view/aadhaaar_otp_verification.dart';
import 'package:app_here/view/aadhaar_card_verification.dart';
import 'package:app_here/view/apply_loan.dart';
import 'package:app_here/view/bank_details_verification.dart';
import 'package:app_here/view/dashboard_screen.dart';
import 'package:app_here/view/employment_verification_screen.dart';
import 'package:app_here/view/flow_diagram_screen.dart';
import 'package:app_here/view/loan_calculator_screen.dart';
import 'package:app_here/view/loan_confirmation.dart';
import 'package:app_here/view/location_screen.dart';
import 'package:app_here/view/login_screen.dart';
import 'package:app_here/view/login_otp_screen.dart';
import 'package:app_here/view/pan_kyc_verification.dart';
import 'package:app_here/view/pin_code_screen.dart';
import 'package:app_here/view/question_answer_screen.dart';
import 'package:app_here/view/splash_screen.dart';
import 'package:app_here/view/upload_bank_statement.dart';
import 'package:app_here/view/upload_salary_slip.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class MyAppRoutes {
  static const String splashScreen = '/';
  static const String locationScreen = '/locationScreen';
  static const String loginScreen = '/loginScreen';
  static const String loginOtpScreen = "/loginOtpScreen";
  static const String dashboardScreen = "/dashboardScreen";
  static const String applyLoanScreen = "/applyLoanScreen";
  static const String loanCalculatorScreen = "/loanCalculatorScreen";
  static const String questionAnswerScreen = "/questionAnswerScreen";
  static const String flowDiagramScreen = "/flowDiagramScreen";
  static const String pincodeScreen = "/pincodeScreen";
  static const String panKycVerificationScreen = "/panKycVerificationScreen";
  static const String employmentVerificationScreen ="/employmentVerificationScreen";
  static const String bankDetailsVerificationScreen = "/bankDetailsVerificationScreen";
  static const String uploadBankStatementScreen = "/uploadBankStatementScreen";
  static const String uploadSalarySlipScreen = "/uploadSalarySlipScreen";
  static const String aadhaarCardVerificationScreen ="/aadhaarCardVerificationScreen";
  static const String aadhaarOtpVerification ="/aadhaarOtpVerification";
  static const String loanConfirmation ="/loanConfirmation";

  static final List<GetPage> pages = [
    GetPage(
      name: MyAppRoutes.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 3),
    ),
    GetPage(name: MyAppRoutes.locationScreen, page: () => LocationScreen()),
    GetPage(name: MyAppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: MyAppRoutes.loginOtpScreen, page: () => LoginOtpScreen()),
    GetPage(name: MyAppRoutes.dashboardScreen, page: () => DashboardScreen()),
    GetPage(
        name: MyAppRoutes.applyLoanScreen, page: () => const ApplyLoanScreen()),
    GetPage(
        name: MyAppRoutes.loanCalculatorScreen,
        page: () => LoanCalculatorScreen()),
    GetPage(
        name: MyAppRoutes.questionAnswerScreen,
        page: () => QuestionAnswerScreen()),
    GetPage(
        name: MyAppRoutes.flowDiagramScreen,
        page: () => const FlowDiagramScreen()),
    GetPage(name: MyAppRoutes.pincodeScreen, page: () =>  PinCodeScreen()),
    GetPage(
        name: MyAppRoutes.panKycVerificationScreen,
        page: () => PanKycVerification()),
    GetPage(
        name: MyAppRoutes.employmentVerificationScreen,
        page: () => EmploymentVerificationScreen()),
    GetPage(
        name: MyAppRoutes.bankDetailsVerificationScreen,
        page: () => BankDetailsVerification()),
    GetPage(
        name: MyAppRoutes.uploadBankStatementScreen,
        page: () =>  UploadBankStatement()),
    GetPage(
        name: MyAppRoutes.uploadSalarySlipScreen,
        page: () => UploadSalarySlipScreen()),
    GetPage(
        name: MyAppRoutes.aadhaarCardVerificationScreen,
        page: () =>  AadhaarVerificationSCreen()),
    GetPage(
        name: MyAppRoutes.aadhaarOtpVerification,
        page: () =>  AadhaarOtpVerification()),
    GetPage(
        name: MyAppRoutes.loanConfirmation,
        page: () => const LoanConfirmation ()),
  ];
}
