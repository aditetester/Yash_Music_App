import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/music_player_logo.jpg',
              fit: BoxFit.cover,

              // This makes sure the image fills the screen properly
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.network(
                'https://media.licdn.com/dms/image/v2/D4D0BAQG8PnbuFX8cfA/company-logo_200_200/company-logo_200_200/0/1719550837248/adite_technologies_llp_logo?e=2147483647&v=beta&t=uATlUtOx4iYye3zXutZePmn4Xg98RWXWvo376-NTFrc', // Replace with actual image URL or asset path
                height: 50,
              ),
              const SizedBox(height: 10),
              const Text(
                'www.aditetech.in',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
