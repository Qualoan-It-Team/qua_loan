import 'package:get/get.dart';

class QuestionAnswerController extends GetxController{


final List<bool> isExpanded = List.generate(5, (index) => false);
final List<String> questions = [
    "What is Only1loan? How does it work?",
    "How can Only1loan help me?",
    "How is Only1loan different from a traditional bank?",
    "How do I apply for a loan with Only1loan?",
    "How long does it take to get the loan approved?",
  ];
final List<String> answers = [
    "Only1loan is your digital lending buddy! We are here to offer fast, hassle-free personal loans, especially for salaried individuals who have struggled with traditional bank loans.",
    "Only1loan is here to offer fast, hassle-free personal loans. We provide financial solutions tailored to your needs for emergencies, weddings, and more.",
    "Unlike traditional banks that may reject loan applications based on strict criteria, Only1loan is part of Naman Finlease Private Limited, an RBI-registered NBFC. We specialize in providing loans to people who may not meet traditional lending standards. We offer quick approvals, minimal paperwork, and fast fund transfers, making borrowing easy and stress-free.",
    "It’s super simple! Just follow these 3 steps:\n• Fill in your basic details\n• Upload your KYC documents (PAN, Aadhaar, salary slips, and bank statements)\n• Get instant credit directly into your bank account once approved!",
    "At Only1loan, we value your time! Once you’ve submitted your details and documents, our advanced financial technology processes your application within minutes. Upon approval, the funds are transferred to your bank account instantly.",
  ];

  void toggleExpansion(int index) {
      isExpanded[index] = !isExpanded[index];
      update();
  }
}