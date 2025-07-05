import 'package:cc_template_dev/app/constant/app_asset.dart';
import 'package:cc_template_dev/app/helper/extension_helper.dart';
import 'package:cc_template_dev/app/utills/dimension.dart';
import 'package:cc_template_dev/app/widgets/app_background.dart';
import 'package:cc_template_dev/app/widgets/app_image_assets.dart';
import 'package:cc_template_dev/app/widgets/app_text.dart';
import 'package:cc_template_dev/screen/splash/splash_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenHelper? splashScreenHelper;

  @override
  Widget build(BuildContext context) {
    'Current screen --> $runtimeType'.logs();
    splashScreenHelper ??= SplashScreenHelper(this);
    return const Scaffold(
      body: AppBackground(
        child: Center(child: AppText('Splash')),
      ),
    );
  }
}
