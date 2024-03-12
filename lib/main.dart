
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modunapp/shared/colors.dart';
import 'package:modunapp/shared/constants.dart';
import 'package:modunapp/splash.dart';
import 'package:sizer/sizer.dart';

void main() 
{
  // it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();  

  IS_DEVELOPMENT_MODE = kDebugMode; // kDebugMode, kReleaseMode
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      navigatorKey: MyApp.navigatorKey,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: Sizer(builder: (context, orientation, devicetype) { return Splash(); }),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY),
        useMaterial3: true,
      ),
    );
  }
}

