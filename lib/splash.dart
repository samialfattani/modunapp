import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modunapp/webb.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import '../../shared/colors.dart';


class Splash extends StatefulWidget 
{
  @override 
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> 
{
  bool? loginStatus = true;
  
  PackageInfo? info;
  String loading_desc = "";


  @override
  void initState() 
  {
    super.initState();

    LoadEveryThing();
  }

  LoadEveryThing() async 
  {

    setState(() { loading_desc = "Getting device information..."; });
    this.info = await PackageInfo.fromPlatform();


    setState(() { loading_desc = "Collecting cache data..."; });
    // await CacheHelper.init();
    // CacheHelper.assignConstantsFromCache();

  
    setState(() { loading_desc = "Connecting to Firebase Messaging..."; });
    //---------------

    setState(() { loading_desc = "جاري الدخول..."; });
    await Future.delayed(Duration(seconds: 2)); 

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Web() )
      );          

  }

  @override
  Widget build(BuildContext context) 
  {

    return Scaffold(
      backgroundColor: PRIMARY,
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.bottomCenter,
        color: WHITE,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: AnimatedContainer(
              curve: Curves.easeInCirc,
              duration: Duration(seconds: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  // Image.asset( "assets/logo.png", width: 150,),
                  Image.asset( "assets/splash.png", width: 300,),

                  // SizedBox(height: 5.h),
                  // Text(
                  //   "مرحباً بكم في منصة مدن العقارية",
                  //   style: GoogleFonts.almarai(color: PRIMARY, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  // ),
                  
                  SizedBox(height: 10.h),

                  Text(
                    "برمجة م/سامي الفتني",
                    style: GoogleFonts.almarai(color: PRIMARY, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  
                  SizedBox(height: 5.h),
                  Text(
                    this.info == null? ""
                    :
                    "version: ${this.info?.version}+${this.info?.buildNumber} ",
                    style: GoogleFonts.courierPrime(color: PRIMARY, fontSize: 12.sp,),
                  ),
          
                  const Spacer(),
                  Text(
                    this.loading_desc,
                    style: GoogleFonts.courierPrime(color: PRIMARY, fontSize: 9.sp, ),
                  ),
          
                  SizedBox(height: 2.h),
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
