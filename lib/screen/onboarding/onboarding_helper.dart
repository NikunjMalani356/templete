import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cc_template_dev/app/helper/extension_helper.dart';
import 'package:cc_template_dev/serialized/onboarding_model.dart';
import 'package:flutter/scheduler.dart';
import 'onboarding_screen.dart';

class OnBoardingScreenHelper {
  OnboardingScreenState state;
  List<OnBoardingModel> onboardingData = [];
  CarouselSliderController carouselController = CarouselSliderController();
  int currentPage = 0;
  Timer? autoSlideTimer;

  OnBoardingScreenHelper(this.state) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await getOnboardingData();
      updateState();
    });
  }

  void updateState() => state.onboardingController?.update();

  void manageCurrentPage(int value) {
    currentPage = value;
    updateState();
  }

  Future<void> getOnboardingData() async {
    final Map<String, dynamic>? utillsData = await state.onboardingController?.utillsRepository.getUtillsData('onboarding');
    if (utillsData != null && utillsData.containsKey('onSliders')) {
      'utillsData --> $utillsData'.logs();
      onboardingData = (utillsData['onSliders'] as List).map((e) => OnBoardingModel.fromJson(e as Map<String, dynamic>)).toList();
    }
  }
}
