import 'package:cc_template_dev/app/constant/color_constant.dart';
import 'package:cc_template_dev/app/utills/dimension.dart';
import 'package:flutter/material.dart';

import 'app_image_assets.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  final double height;
  final double? width;
  final double fontSize;
  final Color color;
  final Color fontColor;
  final BoxBorder? border;
  final double borderRadius;
  final String? image;
  final String? fontFamily;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final String? suffixIcon;

  const AppButton({
    required this.title,
    super.key,
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.height = Dimens.height20,
    this.width,
    this.fontSize = Dimens.textSizeRegular,
    this.fontFamily,
    this.color = AppColors.appBlack,
    this.fontColor = AppColors.appWhite,
    this.padding,
    this.border,
    this.borderRadius = Dimens.borderTextField,
    this.image,
    this.gradient,
    this.boxShadow,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow,
          gradient: gradient,
          color: color,
        ),
        child: Row(
          mainAxisAlignment: suffixIcon == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            if (image != null) AppImageAsset(image: image ?? ''),
            Flexible(
              child: AppText(
                title,
                color: fontColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                overflow: TextOverflow.ellipsis,
                fontFamily: fontFamily,
              ),
            ),
            if (suffixIcon != null)
              AppImageAsset(
                image: suffixIcon ?? '',
                color: fontColor,
              ),
          ],
        ),
      ),
    );
  }
}
