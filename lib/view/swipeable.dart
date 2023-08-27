import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:page_transition/page_transition.dart';

import 'dashboard_screen.dart';

class SwipeableButton extends StatefulWidget {
  const SwipeableButton({super.key});

  @override
  State<SwipeableButton> createState() => _SwipeableButtonState();
}

class _SwipeableButtonState extends State<SwipeableButton> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 15, right: 5, left: 5),
          child: SwipeableButtonView(
              buttonText: 'SLIDE TO PAYMENT',
              buttonWidget: Container(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
              ),
              activeColor: Color(0xFF009C41),
              isFinished: isFinished,
              onWaitingProcess: () {
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isFinished = true;
                  });
                });
              },
              onFinish: () async {
                // await Navigator.push(
                //     context,
                //     PageTransition(
                //         type: PageTransitionType.fade,
                //         child: DashBoardScreen()));

                //TODO: For reverse ripple effect animation
                setState(() {
                  isFinished = false;
                });
              }),
        ),
      ),
    ));
  }
}
