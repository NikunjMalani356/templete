import 'package:cc_template_dev/app/routes/route_constant.dart' show RouteConstant;
import 'package:get/get.dart';

class RouteHelper {
  static final RouteHelper instance = RouteHelper._internal();

  factory RouteHelper() => instance;

  RouteHelper._internal();

  void goToBack() => Get.back();

  void goToOnBoarding() => Get.toNamed(RouteConstant.onBoarding);
}
