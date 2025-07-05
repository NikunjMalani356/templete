import 'package:cc_template_dev/app/constant/string_constant.dart';
import 'package:cc_template_dev/app/helper/extension_helper.dart';
import 'package:cc_template_dev/repository/authentication/auth_repository.dart';
import 'package:cc_template_dev/repository/authentication/authentication_helper.dart';
import 'package:cc_template_dev/repository/utills/utills_helper.dart';
import 'package:cc_template_dev/repository/utills/utills_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'app/constant/color_constant.dart';
import 'app/routes/route_constant.dart';
import 'app/widgets/app_text.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<UtillsRepository>(UtillsRepositoryImpl());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: GetMaterialApp(
                title: AppStrings.appName,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                  ),
                  useMaterial3: true,
                ),
                debugShowCheckedModeBanner: false,
                locale: Get.deviceLocale,
                initialRoute: RouteConstant.initial,
                getPages: GetPageRouteHelper.routes,
                defaultTransition: Transition.fadeIn,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.noScaling),
                    child: child ?? const SizedBox(),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () => "stackapp.solution@gmail.com".launchStoreRating(),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(alignment: Alignment.center,
                    height: 120,
                    width: 30,
                    decoration: const BoxDecoration(color: AppColors.appBlack),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: AppText(
                        'Feedback',
                        color: AppColors.appWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
