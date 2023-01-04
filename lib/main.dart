/*

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_1/detail_screen.dart';
import 'package:flutter_dashboard_1/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2d3447),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        DetailScreen.routeName: (context) => DetailScreen(),
      },
    ),
  );
}
*/
import 'package:dabbabi_service/providers/app_provider.dart';
import 'package:dabbabi_service/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'util/const.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget? child) {
        return ScreenUtilInit(
          designSize: const Size(423, 900),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context , child)  {
            return GetMaterialApp(
              key: appProvider.key,
              debugShowCheckedModeBanner: false,
              navigatorKey: appProvider.navigatorKey,
              title: Constants.appName,
              theme: appProvider.theme,
              darkTheme: Constants.darkTheme,
              home://HomeScene()
              SplashScreen(),
            );
          }
        );
      },
    );
  }
}
