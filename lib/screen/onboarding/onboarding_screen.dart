import 'package:carousel_slider/carousel_slider.dart';
import 'package:cc_template_dev/app/constant/color_constant.dart';
import 'package:cc_template_dev/app/constant/string_constant.dart';
import 'package:cc_template_dev/app/helper/extension_helper.dart';
import 'package:cc_template_dev/app/utills/dimension.dart';
import 'package:cc_template_dev/app/widgets/app_background.dart';
import 'package:cc_template_dev/app/widgets/app_button.dart';
import 'package:cc_template_dev/app/widgets/app_image_assets.dart';
import 'package:cc_template_dev/app/widgets/app_text.dart';
import 'package:cc_template_dev/app/widgets/app_text_form_field.dart';
import 'package:cc_template_dev/controller/onboarding_controller.dart';
import 'package:cc_template_dev/serialized/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onboarding_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  OnBoardingScreenHelper? onboardingScreenHelper;
  OnboardingController? onboardingController;

  @override
  Widget build(BuildContext context) {
    'Current screen --> $runtimeType'.logs();
    onboardingScreenHelper ??= OnBoardingScreenHelper(this);
    return GetBuilder(
      init: OnboardingController(),
      builder: (OnboardingController controller) {
        onboardingController = controller;
        return Scaffold(
          body: AppBackground(
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    items: List.generate(
                      onboardingScreenHelper?.onboardingData.length ?? 0,
                      (index) => buildOnboardingPage(index),
                    ),
                    carouselController: onboardingScreenHelper?.carouselController,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.7,
                      autoPlayInterval: const Duration(seconds: 3),
                      onPageChanged: (index, reason) => onboardingScreenHelper?.manageCurrentPage(index),
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                    ),
                  ),
                ),
                buildPageIndicator(),
                const SizedBox(height: Dimens.height45),
                AppTextFormField(hintText: 'adasdas',),
                SizedBox(height: 15),
                const AppButton(
                  title: AppStrings.createAccount,
                  color: AppColors.appWhite,
                  fontColor: AppColors.appBlack,
                  margin: EdgeInsets.symmetric(horizontal: DimensPadding.paddingScreenHorizontal),
                ),
                const SizedBox(height: Dimens.height45),
                buildLoginText(),
                const SizedBox(height: Dimens.height45),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          AppStrings.alreadyHaveAccount.tr.toLowerCase(),
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.appWhite,
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: Dimens.height45),
        const InkWell(
          child: AppText(
            AppStrings.signIn,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.appWhite,
          ),
        ),
      ],
    );
  }

  Widget buildOnboardingPage(int index) {
    final OnBoardingModel? data = onboardingScreenHelper?.onboardingData[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensPadding.paddingScreenHorizontal),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(index == 2 ? 15 : 0),
            child: AppImageAsset(
              image: data?.image ?? '',
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: Dimens.height45),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensPadding.paddingScreenHorizontal),
            child: AppText(
              data?.headerLine ?? '',
              fontWeight: FontWeight.w800,
              fontSize: Dimens.textSizeVeryLarge,
              color: AppColors.appWhite,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Dimens.height45),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensPadding.paddingScreenHorizontal),
            child: AppText(
              data?.subHeaderLine ?? '',
              fontWeight: FontWeight.w400,
              color: AppColors.appWhite,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingScreenHelper?.onboardingData.length ?? 0,
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: onboardingScreenHelper?.currentPage == index ? AppColors.appWhite : AppColors.appBlack,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        },
      ),
    );
  }
}
