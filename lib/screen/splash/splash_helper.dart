import 'dart:async';
import 'package:cc_template_dev/app/routes/route_helper.dart';
import 'package:cc_template_dev/screen/splash/splash_screen.dart';

class SplashScreenHelper {
  SplashScreenState state;

  SplashScreenHelper(this.state) {
    manageUser();
  }

  Future<void> manageUser() async {
    Future.delayed(const Duration(seconds: 3), () {
      RouteHelper.instance.goToOnBoarding();
    });
  }
}
