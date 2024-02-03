import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;
  const ClockView({super.key, required this.size});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer timer;
  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi/2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ));
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xff444974);
    var outlineBrush = Paint()
      ..color = Color(0xffEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width/20;
    var centerFillBrush = Paint()..color = Color(0xffEAECFF);
    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/60;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xff748EF6), Color(0xff77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/30;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xffEA74AB), Color(0xfC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/24;

    var dashBrush = Paint()
    ..color = Color(0xffEAECFF)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2;


    canvas.drawCircle(center, radius *0.75, fillBrush);
    canvas.drawCircle(center, radius *0.75, outlineBrush);



    var hourHandX = centerX + radius * 0.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);
    var hourHandY = centerY + radius * 0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi/180);
    var minHandY = centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi/180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandY = centerX + radius * 0.6 * sin(dateTime.second * 6 * pi/180);
    var secHandX = centerY + radius * 0.6 * cos(dateTime.second * 6 * pi/180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius * 0.12, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (double i = 0; i < 360; i+=12){
      var x1 = centerX + outerCircleRadius * cos(i*pi/180);
      var y1 = centerY + outerCircleRadius * sin(i*pi/180);

      var x2 = centerX + innerCircleRadius * cos(i*pi/180);
      var y2 = centerY + innerCircleRadius * sin(i*pi/180);
      canvas.drawLine(Offset(x1, y1),Offset(x2, y2),dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
