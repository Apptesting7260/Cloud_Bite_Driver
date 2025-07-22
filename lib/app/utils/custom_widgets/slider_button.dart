import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SlideButtonExample extends StatelessWidget {
  const SlideButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideAction(
        text: 'Slide After Arrival',
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        outerColor: Colors.transparent,
        innerColor: Colors.transparent,
        sliderButtonIcon: Icon(Icons.arrow_forward, color: Colors.white),
        elevation: 0,
        height: 56,
        borderRadius: 40,
        sliderRotate: false,
        // Custom gradient
        submittedIcon: Icon(Icons.check, color: Colors.white),
        onSubmit: () {
          return null;
        

        },
        // Add gradient by wrapping with Container
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [
                Color(0xFFB6568E),
                Color(0xFF5FB6E3),
                Color(0xFFDAEAF4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
