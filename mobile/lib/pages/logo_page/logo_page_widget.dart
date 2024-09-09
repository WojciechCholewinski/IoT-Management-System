import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile/app_ui/nav/nav.dart';

class LoadingScreenWidget extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreenWidget> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 4080), () {});
    context.goNamed('Dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Tło - GIF pokrywający cały ekran
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.gif',
              fit: BoxFit.cover, // Pokrywa cały ekran
            ),
          ),

          // Efekt zamazania tła
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0, // Intensywność zamazania w poziomie
                sigmaY: 10.0, // Intensywność zamazania w pionie
              ),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),

          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.gif',
              fit: BoxFit.contain,
              // width: 300,
              colorBlendMode: BlendMode.dstATop,
            ),
          ),

          // // Logo na środku
          // Center(
          //   child: Image.asset(
          //     'assets/images/logo4.gif',
          //     fit: BoxFit.contain,
          //     width: 400,
          //     colorBlendMode: BlendMode.dstATop,
          //     // height: double.infinity,
          //   ),
          // ),
        ],
      ),
    );
  }
}
