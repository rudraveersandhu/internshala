import 'package:flutter/material.dart';
import 'package:internshala/screens/main_screen.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  bool _visibleInternshala = false;
  bool _visibleGetHired = false;
  bool _visibleTrusted = false;
  late AnimationController _scaleControllerGetHired;
  late Animation<double> _scaleAnimationGetHired;

  @override
  void initState() {
    super.initState();
    _navigateToHome();
    _animateTexts();
    _setupAnimations();
  }

  void _setupAnimations() {
    _scaleControllerGetHired = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimationGetHired = CurvedAnimation(
      parent: _scaleControllerGetHired,
      curve: Curves.elasticOut,
    );
  }

  void _animateTexts() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _visibleInternshala = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visibleGetHired = true;
    });
    _scaleControllerGetHired.forward();
    await Future.delayed(const Duration(seconds: 1)); // Added delay here
    setState(() {
      _visibleTrusted = true;
    });
  }


  @override
  void dispose() {
    _scaleControllerGetHired.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset('assets/handh.json'),
              Positioned(
                top: 100,
                child: AnimatedOpacity(
                  opacity: _visibleInternshala ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const Text(
                      "Internshala",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 200,
                child: AnimatedOpacity(
                  opacity: _visibleGetHired ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: ScaleTransition(
                    scale: _scaleAnimationGetHired,
                    child: const Text(
                      "Get Hired!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  height: 100,
                    width: 100,
                    child: Lottie.asset('assets/ok.json')),
              ),
              Positioned(
                bottom: 0,
                child: AnimatedOpacity(
                  opacity: _visibleTrusted ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    "Trusted by over 21 Million \n College students & Graduates",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 4500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }
}
