import 'package:build_chicago_project/leaveSumCakeForTheRestOfUs.dart';
import 'package:build_chicago_project/task.dart';
import 'package:flutter/material.dart';

class GoHere extends StatelessWidget {

  Task mainTask;

  GoHere(this.mainTask);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          Positioned.fill(
            child: Container(
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),
          ),
          Positioned(child: LeaveSumCakeForTheRestOfUs(mainTask)),
        ]),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.pink[800];
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
