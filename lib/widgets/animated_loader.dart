import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedLoader extends StatelessWidget {
  const AnimatedLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/loader.json',
          repeat: true,
          reverse: true,
        ),
      ),
    );
  }
}
