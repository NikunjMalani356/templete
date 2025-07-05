import 'dart:io';

import 'package:cc_template_dev/app/constant/color_constant.dart';
import 'package:cc_template_dev/app/constant/string_constant.dart';
import 'package:cc_template_dev/app/helper/extension_helper.dart';
import 'package:cc_template_dev/app/widgets/app_button.dart';
import 'package:cc_template_dev/app/widgets/app_text.dart';
import 'package:cc_template_dev/service/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dimension.dart';

mixin AppFunction {
  static Future<File?> selectImage() async {
    final source = await Get.dialog<ImageSource>(
      AlertDialog(
        backgroundColor: AppColors.appWhite,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             AppText("Select option to upload."),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: AppButton(title: 'Camera', onTap: () => Get.back(result: ImageSource.camera))),
                const SizedBox(width: Dimens.height45),
                Expanded(child: AppButton(title: 'Gallery', onTap: () => Get.back(result: ImageSource.gallery))),
              ],
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      if (source == ImageSource.gallery) {
        final permissionGranted = await PermissionService.instance.requestStorageOrMediaPermission();
        'permissionGranted --> $permissionGranted'.infoLogs();
        if (!permissionGranted) {
          return null;
        } else {
          final pickedFile = await ImagePicker().pickImage(source: source);
          if (pickedFile != null) {
            return File(pickedFile.path);
          }
        }
      }
      if (source == ImageSource.camera) {
        final permissionGranted = await PermissionService.instance.requestPermission(Permission.camera);
        if (!permissionGranted) return null;
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          return File(pickedFile.path);
        }
      }
    }
    return null;
  }

  static Future<void> showExitDialog() async {
    await Get.dialog<bool>(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             AppText(AppStrings.exitAppDescription, fontSize: Dimens.size20, textAlign: TextAlign.center),
            const SizedBox(height: Dimens.height45),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: AppStrings.cancel,
                    onTap: () => Get.back(),
                  ),
                ),
                const SizedBox(width: Dimens.height45),
                Expanded(
                  child: AppButton(
                    title: AppStrings.yes,
                    onTap: () => SystemNavigator.pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showPermissionDialog() async {
    await Get.dialog<bool>(
      barrierDismissible: false,
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             AppText(AppStrings.permissionDescription, fontSize: Dimens.size20, textAlign: TextAlign.center),
            const SizedBox(height: Dimens.height45),
             AppText(AppStrings.permissionSubDescription, fontSize: Dimens.size20, textAlign: TextAlign.center),
            const SizedBox(height: Dimens.height45),
            Row(
              children: [
                Expanded(child: AppButton(title: AppStrings.notNow, onTap: () => Get.back())),
                const SizedBox(width: Dimens.height45),
                Expanded(
                  child: AppButton(
                    title: AppStrings.goToSetting,
                    onTap: () async {
                      final bool isOpened = await openAppSettings();
                      if (isOpened) Get.back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
