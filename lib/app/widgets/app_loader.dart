import 'package:cc_template_dev/app/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: AppColors.appPurple.withValues(alpha: 0.3)),
      child: const Center(child: SpinKitSpinningLines(color: AppColors.appLightPurple)),
    );
  }
}
