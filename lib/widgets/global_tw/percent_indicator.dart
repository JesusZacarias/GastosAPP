import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercIndicLineal extends StatelessWidget {
  final double percent;
  final Color color;
  const PercIndicLineal(
      {super.key, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      lineHeight: 20.0,
      percent: percent,
      barRadius: const Radius.circular(8.0),
      //Muestra la barra de un solo color
      progressColor: color,
      //Muestra la barra con colores gradientes
      //iniciando de arriba a hacia abajo en forma horizontal
      // linearGradient: LinearGradient(
      //   colors: [Colors.black, color, color, color],
      // ),
      center: Text(
        '${(percent * 100).toStringAsFixed(2)}%',
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }
}

class PercIndicCircular extends StatelessWidget {
  final double percent;
  final double radius;
  final Color color;
  final ArcType arcType;
  const PercIndicCircular({
    super.key,
    required this.percent,
    required this.radius,
    required this.color,
    required this.arcType,
  });

  @override
  Widget build(BuildContext context) {
    var _percent = percent;
    var _color = color;
    if(_percent > 1) {
      _percent = 1;
      _color = Colors.red;
    }
    return CircularPercentIndicator(
      animation: true,
      animationDuration: 1000,
      radius: radius,
      percent: _percent,
      progressColor: _color,
      arcType: arcType,
      backgroundWidth: 0.0,
      lineWidth: 15.0,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '${(_percent * 100).toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
