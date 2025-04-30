import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home page after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(164, 223, 221, 234),
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Positioned.fill(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.only( top: 170, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset("assets/svg/splash_logo.svg"),
                SizedBox(height: 10.h),
                SvgPicture.asset("assets/svg/music_player_letter.svg"),

                SizedBox(height: 25.h),
                Image.asset("assets/images/adite_tech_logo.png", height: 7.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
