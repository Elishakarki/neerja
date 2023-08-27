// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:swipeable_button_view/swipeable_widget.dart';

// class DashBoardScreen extends StatefulWidget {
//   const DashBoardScreen({super.key});

//   @override
//   State<DashBoardScreen> createState() => _DashBoardScreenState();
// }

// class _DashBoardScreenState extends State<DashBoardScreen>
//     with TickerProviderStateMixin {
//   AnimationController? rippleController;
//   late AnimationController _controller;
//   Animation<double>? rippleAnimation;
//   AnimationController? scaleController;
//   Animation<double>? scaleAnimation;
//   VoidCallback? onFinish;
//   VoidCallback? onWaitingProcess;
//   bool? isFinished;
//   bool isFinishValue = false;
//   bool isAccepted = false;
//   double opacity = 1;
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     setState(() {});

//     rippleController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 600));
//     scaleController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 800))
//           ..addStatusListener((status) {
//             if (status == AnimationStatus.completed) {
//               setState(() {
//                 isFinishValue = true;
//               });
//             }
//           });
//     rippleAnimation =
//         Tween<double>(begin: 60.0, end: 90.0).animate(rippleController)
//           ..addStatusListener((status) {
//             if (status == AnimationStatus.completed) {
//               rippleController!.reverse();
//             } else if (status == AnimationStatus.dismissed) {
//               rippleController!.forward();
//             }
//           });
//     scaleAnimation =
//         Tween<double>(begin: 1.0, end: 30.0).animate(scaleAnimation!)
//           ..addStatusListener((status) {
//             if (status == AnimationStatus.completed) {
//               setState(() {
                
//               });
//             }
//           });

//     //rippleController.forward();

//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 600))
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(" opacity"),
//       ),
//       body: Center(
//         child: Container(
//             width: double.infinity,
//             height: 60,
//             decoration: BoxDecoration(
//                 color: Colors.green, borderRadius: BorderRadius.circular(30)),
//             child: Stack(
//               children: [
//                 Align(
//                     alignment: Alignment.center,
//                     child: Opacity(
//                         opacity: opacity, child: Text(" Slide to Pay"))),
//                 !isAccepted
//                     ? SwipeableWidget(
//                         child: Container(
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Material(
//                                   elevation: 2,
//                                   shape: CircleBorder(),
//                                   child: Container(
//                                     width: 56,
//                                     height: 56,
//                                     child:
//                                         Center(child: Icon(Icons.forward_10)),
//                                     decoration:
//                                         BoxDecoration(shape: BoxShape.circle),
//                                   ),
//                                 ),
//                               ]),
//                         ),
//                         height: 200,
//                         onSwipeCallback: () {
//                           setState(() {
//                             isAccepted = true;
//                           });
//                         },
//                         onSwipeValueCallback: (value) {
//                           opacity = value;
//                           log(opacity.toString());
//                         },
//                         isActive: true)
//                     : Container(
//                         color: Colors.black,
//                       )
//               ],
//             )

//             //  Stack(
//             //   children: [
//             //     Align(
//             //         alignment: Alignment.center,
//             //         child: Opacity(opacity: 1, child: Text("Slide to payment")))
//             //   ],
//             // )
//             // // Opacity(
//             // //   opacity: 0.6,
//             // //   child: ElevatedButton(
//             // //     onPressed: () {},
//             // //     child: Text(" Opacity"),
//             // //   ),
//             // // ),

//             ),
//       ),
//     );
//   }
// }
