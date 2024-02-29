import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountingContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const CountingContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          // color: Colors.white,
          gradient: LinearGradient(
            colors: [
              Colors.pink.withOpacity(0.1),
              Colors.purple.withOpacity(0.1),
              Colors.blue.withOpacity(0.1),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: Get.height * 0.1,
        width: Get.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Get.height * 0.015,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: Get.height * 0.02,
                color: Colors.purple,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
