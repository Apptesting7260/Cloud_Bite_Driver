import 'package:cloud_bites_driver/app/core/app_exports.dart';

class OnboardingController extends GetxController{
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  updateCurrentPage(int value, bool needUpdatePageCtrl){
    if(needUpdatePageCtrl){
      pageController.animateToPage(value,duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
    }
    currentPage.value = value;
  }

  final List onboardingImages = [
    ImageConstants.onboarding1,
    ImageConstants.onboarding2,
    ImageConstants.onboarding3,
  ];

  final List<String> onboardingTexts = [
    'Order your favorite\nproducts',
    'Easy and Secure\nPayments',
    'Track your orders in\nreal-time',
  ];

  final List<String> descriptionTexts = [
    '',
    'Easy and secure payments with multiple options, including cards and wallets',
    'Stay updated with real-time order tracking and know exactly where your order is',
  ];
}