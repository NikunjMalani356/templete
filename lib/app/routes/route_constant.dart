import 'package:cc_template_dev/screen/onboarding/onboarding_screen.dart';
import 'package:cc_template_dev/screen/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteConstant {
  static const String initial = '/';
  static const String onBoarding = '/onBoarding';
}

mixin GetPageRouteHelper {
  static List<GetPage> routes = [
    GetPage(name: RouteConstant.initial, page: () => const SplashScreen()),
    GetPage(name: RouteConstant.onBoarding, page: () => const OnboardingScreen()),
  ];
}
