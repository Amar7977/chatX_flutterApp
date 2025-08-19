import 'package:flutter/material.dart';

class Signinscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFCFA1), Color(0xFFEEDCF5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          )
        )
    );
  }

}