import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:taxverse/constants.dart';

class GstAnimated extends StatelessWidget {
  const GstAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'Asset/scott-graham-5fNmWej4tAA-unsplash.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
