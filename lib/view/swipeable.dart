import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:page_transition/page_transition.dart';

import 'dashboard_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SwipeableButton extends StatefulWidget {
  const SwipeableButton({super.key});

  @override
  State<SwipeableButton> createState() => _SwipeableButtonState();
}

class _SwipeableButtonState extends State<SwipeableButton> {
  final TextEditingController messageController = TextEditingController();
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Some ready'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: Container(
                height: context.screenHeight,
              )),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: messageController,
                  ))
                ],
              )
            ],
          ).pOnly(left: 10, right: 10),
        ));
  }
}
